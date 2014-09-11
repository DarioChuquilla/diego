class AddRoomidToSpecialty < ActiveRecord::Migration
  def change
    add_column :specialties, :room_id, :integer
  end
end
