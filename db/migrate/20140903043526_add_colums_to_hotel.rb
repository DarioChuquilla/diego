class AddColumsToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :type_name, :string
  end
end
