class ApplicationController < ActionController::Base

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

  def join_room
    Membership.create!(
        person: Person.find(params[:id]),
        room: Room.find(params[:room_id])
    )
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
        Membership.create!(
            person: person,
            room: invitation.room
        )
        render json: {person_exists: true}
      end
    end

  end

  def setup_person
    invitation = Invitation.find_by(token: params[:token])
    if !invitation.nil?
      person = Person.create!(email: invitation.email, handle: params[:handle])
      Membership.create!(person: person, room: invitation.room)
      invitation.destroy!
      render json: {}
    else
      response.status = 404
      render json: {}
    end
  end

end
