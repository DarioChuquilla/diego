class HotelController < ApplicationController
  def show
    @hotel = Hotel.find params[:id]
  end

  def nearest
  end

  def price
  end

  def cities
  end

  def promo
  end
end
