class Admin::Hotel < ActiveRecord::Base
  attr_accessible :address, :description, :latitude, :longitude, :name
end
