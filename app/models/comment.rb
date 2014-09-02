class Comment < ActiveRecord::Base
  has_one :hotel
  has_one :user
  attr_accessible :date, :description, :hotel_id, :rank, :status, :user_id

  scope :active, where(active: true)
end
