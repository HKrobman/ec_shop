class RenamePaymentIdColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :payment_id, :payment_method_id
  end
end
