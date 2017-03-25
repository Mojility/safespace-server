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
end