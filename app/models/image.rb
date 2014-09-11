class Image < ActiveRecord::Base
  mount_uploader :file, PhotoUploader
  attr_accessible :caption, :file
  validates_presence_of :file
end
