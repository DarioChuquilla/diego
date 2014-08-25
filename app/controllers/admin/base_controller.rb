class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!

  private
  
  def authenticate_admin!
    authenticate_user!
  end

  def get_hotel
     begin
      @hotel = Hotel.find(params[:hotel_id])
      authorize! :manage, @hotel
    rescue CanCan::AccessDenied => e
      p e.message.inspect
      redirect_to(not_found_page_path, :alert => e.message) and return
    end
  end

  def get_room
     begin
      @room = Room.find params[:room_id]
      authorize! :manage, @room
    rescue CanCan::AccessDenied => e
      p e.message.inspect
      redirect_to(not_found_page_path, :alert => e.message) and return
    end
  end
end