require "rails_helper"

RSpec.describe MilitarySchool, :type => :model do
  it "calculates average score as 0" do
    school = MilitarySchool.create!()
    expect(school.avg_score(1)).to eq(0)
  end

  describe "calculating needed points" do
    it "always returns 0" do
      school = MilitarySchool.create!()
      expect(school.needed_points(350, 1)).to eq(0)
    end
  end

  describe "calculating acceptance chance" do
    it "returns high chance for scores above 48" do
      school = MilitarySchool.create!()
      expect(school.acceptance_chance(350, 60, 1)).to eq("high")
    end

    it "returns no chance for scores below 48" do
      school = MilitarySchool.create!()
      expect(school.acceptance_chance(350, 30, 1)).to eq("no")
    end
  end

end
