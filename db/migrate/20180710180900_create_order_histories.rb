class CreateOrderHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :order_histories do |t|
      t.integer :user_id
      t.integer :item_id
      t.date :orderd_at

      t.timestamps
    end
  end
end
