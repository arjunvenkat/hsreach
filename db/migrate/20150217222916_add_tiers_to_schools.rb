class AddTiersToSchools < ActiveRecord::Migration
  def change
    remove_column :schools, :avg_score, :integer
    add_column :schools, :tier1_score, :integer
    add_column :schools, :tier2_score, :integer
    add_column :schools, :tier3_score, :integer
    add_column :schools, :tier4_score, :integer
  end
end
