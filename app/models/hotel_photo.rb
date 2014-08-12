class HotelPhoto < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  attr_accessible :hotel_id, :photo
  validates_presence_of :hotel_id, :photo
  belongs_to :hotel
end
