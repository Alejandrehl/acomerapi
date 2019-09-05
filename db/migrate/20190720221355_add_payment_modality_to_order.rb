class AddPaymentModalityToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment_modality, :string
  end
end
