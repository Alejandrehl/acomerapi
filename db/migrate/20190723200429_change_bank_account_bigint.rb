class ChangeBankAccountBigint < ActiveRecord::Migration[5.2]
  def change
    change_column :bank_accounts, :account_number, :bigint
  end
end
