class AddOfferActivatedToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :offer_activated, :boolean, default: false
  end
end
