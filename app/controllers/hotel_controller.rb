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

  def get_hotels_nearby
    level = params[:level].to_i
    base = 14
    range = 0
    @radious = 0
    if level <= base
      range = base - level
      @radious = 2**range
    else
      range = level - base
      @radious = ((7.0 - range) / (range.to_f - 3.0) ).to_f
    end
    @hotels = Hotel.near "#{params[:lat]}, #{params[:lng]}", @radious
    respond_to do |format|
      format.js # show.html.erb
      format.json { render json: @hotels }
    end
  end
end
