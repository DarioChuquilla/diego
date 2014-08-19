class RemoveFieldsFromPromotion < ActiveRecord::Migration
  def change
    remove_column :promotions, :code
    remove_column :promotions, :initial_date
    remove_column :promotions, :end_date
    remove_column :promotions, :description
    remove_column :promotions, :percentage_discount
    add_column :promotions, :photo, :string
  end
end
