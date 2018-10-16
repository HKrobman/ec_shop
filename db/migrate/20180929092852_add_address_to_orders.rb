class AddAddressToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :addressee_name_kanji, :string
    add_column :orders, :addressee_name_kana, :string
    add_column :orders, :addressee_zip_code, :string
    add_column :orders, :addressee_prefecture, :string
    add_column :orders, :addressee_city, :string
    add_column :orders, :addressee_address1, :string
    add_column :orders, :addressee_address2, :string
    add_column :orders, :total_price, :decimal
  end
end
