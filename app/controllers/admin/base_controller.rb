class Admin::BaseController < ApplicationController
  before_filter :authenticate_admin!

  private
  
  def authenticate_admin!
    authenticate_user!
  end

  def get_hotel
    @hotel = Hotel.find params[:hotel_id]
  end
end