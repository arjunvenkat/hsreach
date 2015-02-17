class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.integer :avg_score
      t.string :category
      t.string :address
      t.float :lat
      t.float :long

      t.timestamps

    end
  end
end
