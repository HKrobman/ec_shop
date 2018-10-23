class AddRankToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :rank, :integer
  end
end
