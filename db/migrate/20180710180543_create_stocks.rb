class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.integer :product_id
      t.integer :quantity
      t.integer :sales_quantity
      t.date :arriving_on
      t.string :comment

      t.timestamps
    end
  end
end
