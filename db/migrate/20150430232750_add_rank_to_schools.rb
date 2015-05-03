class AddRankToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :rating, :integer
  end
end
