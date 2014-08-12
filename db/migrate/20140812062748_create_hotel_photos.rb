class CreateHotelPhotos < ActiveRecord::Migration
  def change
    create_table :hotel_photos do |t|
      t.integer :hotel_id
      t.string :photo

      t.timestamps
    end
  end
end
