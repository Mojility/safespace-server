class ApiController < ApplicationController
  respond_to :json

  # person_exists, auth_token
  def validate_invitation
    invitation = Invitation.find_by(token: params[:token])

    if invitation.nil?
      response.status = 404
      render json: {}
    else
      person = Person.find_by(email: invitation.email)
      if person.nil?
        render json: {person_exists: false} # ValidateResponse
      else
        render json: {person_exists: true, auth_token: person.auth} # ValidateResponse
      end
    end

  end

  # auth_token
  def setup_person
    invitation = Invitation.find_by(token: params[:token])
    if !invitation.nil?
      person = Person.create!(email: invitation.email, handle: params[:handle])
      render json: {token: person.auth} # Authorization
    else
      response.status = 404
      render json: {}
    end
  end

  # emotes, rooms
  def metadata
    if Person.exists?(auth: request.headers['auth'])
      # RoomsAndEmotes
      @rooms = Room.all
      @emotes = Emote.all
    else
      response.status = 404
      render json: {}
    end
  end

  # auth_token
  def join_room
    invitation = Invitation.find_by(token: params[:token])
    person = Person.find_by(email: invitation.email)
    Membership.create!(
        person: person,
        room: invitation.room
    )
    invitation.destroy!
    render json: {token: person.auth} # Authorization
  end

  # infractions, posts
  def get_posts
    person = Person.find_by(auth: request.headers['auth'])
    @room = Room.find(params[:room_id])

    if Membership.exists?(person: person, room: @room)
      # PostsAndInfractions
      @posts = @room.posts
    else
      response.status = 401
      render json: {}
    end
  end

  # status only
  def post_post
    person = Person.find_by(auth: request.headers['auth'])
    room = Room.find(params[:room_id])

    if Membership.exists?(person: person, room: room)
      Post.create!(room: room, person: person, body: params[:body])
    else
      response.status == 401
      render json: {}
    end
  end

  # status only
  def emote_on_post
    person = Person.find_by(auth: request.headers['auth'])
    room = Room.find(params[:room_id])
    post = Post.find(params[:post_id])
    emote = Emote.find(params[:emote_id])

    if Membership.exists?(person: person, room: room) && !EmoteEvent.exists?(person: person, post: post, emote: emote)
      EmoteEvent.create!(person: person, post: post, emote: emote)
    else
      response.status = 400
      render json: {}
    end
  end

  # status only
  def remove_emote_from_post
    person = Person.find_by(auth: request.headers['auth'])
    post = Post.find(params[:post_id])
    emote = Emote.find(params[:emote_id])

    event = EmoteEvent.find_by(person: person, post: post, emote: emote)
    event.destroy
  end

  # status only
  def callout
    person = Person.find_by(auth: request.headers['auth'])
    room = Room.find(params[:room_id])
    post = Post.find(params[:post_id])
    infraction = Infraction.find(params[:infraction_id])

    if Membership.exists?(person: person, room: room) && !InfractionEvent.exists?(person: person, post: post, infraction: infraction)
      InfractionEvent.create!(person: person, post: post, infraction: infraction)
    else
      response.status = 400
      render json: {}
    end
  end

  # status only
  def remove_infraction
    person = Person.find_by(auth: request.headers['auth'])
    post = Post.find(params[:post_id])
    infraction = Infraction.find(params[:infraction_id])

    event = InfractionEvent.find_by(person: person, post: post, infraction: infraction)
    event.destroy
  end

  # status only
  def create_infraction
    person = Person.find_by(auth: request.headers['auth'])
    room = Room.find(params[:room_id])

    if Membership.exists?(person: person, room: room) && !Infraction.exists?(room: room, label: params[:label])
      Infraction.create!(room: room, label: params[:label])
    else
      response.status = 401
      render json: {}
    end
  end

  # status only
  def rate_infraction
    person = Person.find_by(auth: request.headers['auth'])
    room = Room.find(params[:room_id])
    infraction = Infraction.find(params[:infraction_id])

    if Membership.exists?(person: person, room: room)
      begin
        rating = InfractionRating.find_by(person: person, infraction: infraction)
        raise ActiveRecord::RecordNotFound if rating.nil?
        rating.rating = params[:rating]
        rating.save!
      rescue ActiveRecord::RecordNotFound
        InfractionRating.create!(infraction: infraction, rating: params[:rating], person: person)
      end
    else
      response.status = 401
      render json: {}
    end
  end
end