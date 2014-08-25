class RoomPhoto < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  attr_accessible :photo, :room_id
  validates_presence_of :room_id, :photo
  belongs_to :room
  has_one :hotel, :through => :room
end
