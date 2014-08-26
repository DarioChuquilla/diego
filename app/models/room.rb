class Room < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  attr_accessible :photo, :name, :description, :amount
  belongs_to :hotel
  has_many :room_photos
  validates_presence_of :photo, :name, :description, :amount, :hotel_id
  before_destroy :remove_photos

  private

  def remove_photos
    self.room_photos.destroy_all
  end
end
