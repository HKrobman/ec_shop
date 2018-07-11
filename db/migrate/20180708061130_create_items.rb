class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :category_id
      t.string :company
      t.date :released_on
      t.string :code
      t.decimal :list_price
      t.decimal :sale_price
      t.text :description
      t.string :image_url
      t.string :color
      t.integer :delivery_days
      t.integer :active

      t.timestamps
    end
  end
end
