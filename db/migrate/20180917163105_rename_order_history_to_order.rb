class RenameOrderHistoryToOrder < ActiveRecord::Migration[5.2]
  def change
    rename_table :order_histories, :orders
  end
end
