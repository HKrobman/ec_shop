class AddColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_telphone, :string
  end
end
