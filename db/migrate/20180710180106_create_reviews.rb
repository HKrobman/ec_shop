class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :item_id
      t.text :description
      t.string :rank
      
      t.timestamps
    end
  end
end
