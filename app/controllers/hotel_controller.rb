class HotelController < ApplicationController
  def show
    @hotel = Hotel.find params[:id]
  end

  def nearest
    @type_name = params[:type_name].present? ? params[:type_name] : 'Motel'
    logger.debug{"============ TYPE_NAME #{@type_name.inspect}"}
    @hotels = Hotel.active.where('hotels.type_name = ?', @type_name)
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

  def reservations
    @hotel = Hotel.find params[:id]
    @room = Room.find params[:room_id]
  end

  def get_hotels_nearby
    # @radious = (params[:distance].to_f) / 1000 #Distance is requested in meters, setting it to KMs
    @radious = ((params[:distance].to_f * 1.02) / 1000.0) * Math.sin(Geocoder::Calculations.to_radians(45)) #Distance for circular maps canvas
    box = Geocoder::Calculations.bounding_box([params[:lat], params[:lng]], @radious, :units => :km)
    # @hotels = Hotel.active.near [params[:lat], params[:lng]], @radious, :units => :km #for circular map
    @type_name = params[:type_name].present? ? params[:type_name] : 'Motel'

    @hotels = Hotel.active.where('hotels.type_name = ?', @type_name).within_bounding_box(box)
    respond_to do |format|
      format.js # show.html.erb
      format.json { render json: @hotels }
    end
  end
end
