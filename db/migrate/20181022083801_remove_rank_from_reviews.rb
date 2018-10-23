class RemoveRankFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :rank, :string
  end
end