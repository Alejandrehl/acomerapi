class AddRestaurantToBankAccount < ActiveRecord::Migration[5.2]
  def change
    add_reference :bank_accounts, :restaurant, foreign_key: true
  end
end
