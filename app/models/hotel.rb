class Hotel < ActiveRecord::Base
  attr_accessible :description, :latitude, :longitude, :name, :telephone, :email
  validates_presence_of :name, :description
  belongs_to :user
  has_many :promotions
  has_many :rooms
  has_many :hotel_photos

  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode, :if => :address_changed?

  before_destroy :remove_related

  scope :active, where('active = ?', true)

  private

  def remove_related
    self.promotions.destroy_all
    self.rooms.destroy_all
    self.hotel_photos.destroy_all
  end

end
