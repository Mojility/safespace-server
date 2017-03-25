class ApiController < ApplicationController
  respond_to :json

  def register_user
    Person.create! email: params[:email], handle: params[:handle]
  end

  def rooms_for_user
    person = Person.find(params[:id])
    render json: person.rooms
  end

  def rooms
    render json: Room.all
  end

  def create_post
    Post.create!(
        person: Person.find(params[:id]),
        room: Room.find(params[:room_id]),
        body: params[:body]
    )
  end

  def validate_invitation
    invitation = Invitation.find_by(token: params[:token])

    if invitation.nil?
      response.status = 404
      render json: {}
    else
      person = Person.find_by(email: invitation.email)
      if person.nil?
        render json: {person_exists: false}
      else
        render json: {person_exists: true}
      end
    end

  end

  def setup_person
    invitation = Invitation.find_by(token: params[:token])
    if !invitation.nil?
      Person.create!(email: invitation.email, handle: params[:handle])
      render json: {}
    else
      response.status = 404
      render json: {}
    end
  end

  def join_room
    invitation = Invitation.find_by(token: params[:token])
    person = Person.find_by(email: invitation.email)
    Membership.create!(
        person: person,
        room: invitation.room
    )
    invitation.destroy!
  end

  def metadata
    if Person.exists?(auth: params[:auth])
      @rooms = Room.all
      @emotes = Emote.all
    else
      response.status = 404
      render json: {}
    end
  end

  def get_posts
    person = Person.find_by(auth: URI.decode(params[:auth]))
    room = Room.find(params[:room_id])

    if Membership.exists?(person: person, room: room)
      @posts = room.posts
    else
      response.status = 401
      render json: {}
    end
  end

  def post_post
    person = Person.find_by(auth: [params[:auth]])
    room = Room.find(params[:room_id])

    if Membership.exists?(person: person, room: room)
      Post.create!(room: room, person: person, body: params[:body])
    else
      response.status == 401
      render json: {}
    end
  end

  def emote_on_post
    person = Person.find_by(auth: [params[:auth]])
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

  def remove_emote_from_post
    person = Person.find_by(auth: [params[:auth]])
    post = Post.find(params[:post_id])
    emote = Emote.find(params[:emote_id])

    event = EmoteEvent.find_by(person: person, post: post, emote: emote)
    event.destroy
  end

  def callout
    person = Person.find_by(auth: [params[:auth]])
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

  def remove_callout
    person = Person.find_by(auth: [params[:auth]])
    post = Post.find(params[:post_id])
    infraction = Infraction.find(params[:infraction_id])

    event = InfractionEvent.find_by(person: person, post: post, infraction: infraction)
    event.destroy
  end
end