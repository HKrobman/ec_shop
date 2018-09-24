class AddColumnToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :pay_type, :string
  end
end
