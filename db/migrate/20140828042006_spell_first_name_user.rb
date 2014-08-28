class SpellFirstNameUser < ActiveRecord::Migration
  def change
    remove_column :users, :frist_name
    add_column :users, :first_name, :string
  end

end
