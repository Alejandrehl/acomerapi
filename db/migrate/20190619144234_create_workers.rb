class CreateWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :workers do |t|
      t.references :user, foreign_key: true
    end
  end
end
