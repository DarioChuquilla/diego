class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :name
      t.date :initial_date
      t.date :end_date
      t.text :description
      t.string :code
      t.decimal :percentage_discount

      t.timestamps
    end
  end
end
