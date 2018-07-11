class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :item_id
      t.integer :quantity
      t.integer :sales_quantity
      t.date :arriving_on
      t.string :comment

      t.timestamps
    end
  end
end
