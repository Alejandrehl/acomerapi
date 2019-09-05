class CreateFeaturedBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :featured_branches do |t|
      t.references :branch, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
