class RenameOrderAtColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :orderd_at, :delivery_date
  end
end
