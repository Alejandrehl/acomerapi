class CreateBankAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_accounts do |t|
      t.string :business_name
      t.integer :business_rut
      t.string :business_email
      t.string :bank_name
      t.string :account_type
      t.integer :account_number
      t.timestamps
    end
  end
end
