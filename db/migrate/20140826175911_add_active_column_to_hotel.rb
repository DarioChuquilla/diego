class AddActiveColumnToHotel < ActiveRecord::Migration
  def change
    add_column :hotels, :active, :boolean, :default => false
  end
end
