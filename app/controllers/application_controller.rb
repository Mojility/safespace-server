class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def register_user
    Person.create! email: params[:email], handle: params[:handle]
  end

  def rooms_for_user
    person = Person.find(params[:id])
    render json: Room.where(person: person)
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

end
