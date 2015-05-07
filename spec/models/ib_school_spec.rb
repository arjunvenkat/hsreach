require "rails_helper"

RSpec.describe IbSchool, :type => :model do
  it "calculates average score" do
    school = IbSchool.create!(tier1_score: 550)
    expect(school.avg_score(1)).to eq(550)
  end

  describe "calculating needed points" do
    it "uses tier information" do
      school = IbSchool.create!(tier1_score: 550)
      expect(school.needed_points(300, 1)).to eq(250)
    end

    it "turns negative needed points to 0" do
      school = IbSchool.create!(tier1_score: 550)
      expect(school.needed_points(600, 1)).to eq(0)
    end
  end

  describe "calculating acceptance chance" do
    it "calculates high acceptance chance" do
      school = IbSchool.create!(tier1_score: 600)
      expect(school.acceptance_chance(400, 90, 1)).to eq("high")
    end

    it "calculates medium acceptance chance" do
      school = IbSchool.create!(tier1_score: 600)
      expect(school.acceptance_chance(340, 90, 1)).to eq("medium")
    end

    it "calculates low acceptance chance" do
      school = IbSchool.create!(tier1_score: 600)
      expect(school.acceptance_chance(310, 90, 1)).to eq("low")
    end

    it "calculates no acceptance chance" do
      school = IbSchool.create!(tier1_score: 600)
      expect(school.acceptance_chance(280, 90, 1)).to eq("no")
    end
  end

end
