class AddRatingRatingTotalAndQuantityVotingToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :rating, :integer, default: 0
    add_column :restaurants, :rating_total, :integer, default: 0
    add_column :restaurants, :quantity_voting, :integer, default: 0
  end
end
