class CreateOrderHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :order_histories do |t|
      t.integer :user_id
      t.integer :product_id
      t.date :orderd_at

      t.timestamps
    end
  end
end
