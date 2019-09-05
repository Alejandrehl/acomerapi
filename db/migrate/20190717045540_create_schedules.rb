class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :day
      t.time :opening
      t.time :closing
      t.references :branch, foreign_key: true

      t.timestamps
    end
  end
end
