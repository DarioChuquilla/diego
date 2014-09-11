class AddHotelIdToSpecialty < ActiveRecord::Migration
  def change
    add_column :specialties, :hotel_id, :integer
  end
end
