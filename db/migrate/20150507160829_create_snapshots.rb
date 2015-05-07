class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.integer :user_id
      t.integer :nwea_math
      t.integer :nwea_reading
      t.string :math
      t.string :reading
      t.string :science
      t.string :social_studies

      t.timestamps null: false
    end
  end
end
