class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def rooms_for_user
    render json: Room.all
  end

end
