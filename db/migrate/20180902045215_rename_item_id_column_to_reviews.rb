class RenameItemIdColumnToReviews < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :item_id, :product_id
  end
end
