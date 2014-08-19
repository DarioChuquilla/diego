class Promotion < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  attr_accessible :name, :photo, :hotel_id
  belongs_to :hotel
  validates_presence_of :name, :photo, :hotel_id
end
