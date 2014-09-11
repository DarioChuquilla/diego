class HomeController < ApplicationController
  def index
    @images = Image.order(:id)
  end
end
