class RenameItemIdColumnToMylists < ActiveRecord::Migration[5.2]
  def change
    rename_column :mylists, :item_id, :product_id
  end
end
