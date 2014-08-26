class HotelController < ApplicationController
  def show
    @hotel = Hotel.find params[:id]
  end

  def nearest
    @hotels = Hotel.where('hotels.active = ?', true)
  end

  def room
    @hotel = Hotel.find params[:id]
    @room = Room.find params[:room_id]
  end

  def price
  end

  def cities
  end

  def promo
  end
end
