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
    # @radious = (params[:distance].to_f) / 1000 #Distance is requested in meters, setting it to KMs
    @radious = ((params[:distance].to_f * 1.02) / 1000.0) * Math.sin(Geocoder::Calculations.to_radians(45)) #Distance for circular maps canvas
    @hotels = Hotel.active.near [params[:lat], params[:lng]], @radious, :units => :km
    respond_to do |format|
      format.js # show.html.erb
      format.json { render json: @hotels }
    end
  end
end
