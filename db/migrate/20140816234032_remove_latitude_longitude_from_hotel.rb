class RemoveLatitudeLongitudeFromHotel < ActiveRecord::Migration
  def change
    remove_column :hotels, :latitude
    remove_column :hotels, :longitude
  end

end
