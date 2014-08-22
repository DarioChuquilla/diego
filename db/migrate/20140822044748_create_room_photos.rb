class CreateRoomPhotos < ActiveRecord::Migration
  def change
    create_table :room_photos do |t|
      t.integer :room_id
      t.string :photo

      t.timestamps
    end
  end
end
