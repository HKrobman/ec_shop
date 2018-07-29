class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :product_id
      t.text :description
      t.string :rank
      
      t.timestamps
    end
  end
end
