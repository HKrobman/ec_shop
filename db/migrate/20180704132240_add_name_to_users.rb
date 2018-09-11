class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name_kanji, :string
    add_column :users, :name_kana, :string
    add_column :users, :payment_id, :integer
    add_column :users, :telphone, :string
    add_column :users, :zip_code, :string
    add_column :users, :prefecture, :string
    add_column :users, :city, :string
    add_column :users, :address1, :string
    add_column :users, :address2, :string
  end
end
