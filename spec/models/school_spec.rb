require "rails_helper"

RSpec.describe School, :type => :model do
  it "calculates total score" do
    nwea_math = 70
    nwea_reading = 60
    math = "a"
    reading = "b"
    science = "b"
    social_studies = "c"
    score = School.total_score_for(nwea_math, nwea_reading, math, reading, science, social_studies)

    expect(score).to eq(397)
  end

  it  "calculates map score" do
    expect(School.map_score_for("35", "25")).to eq(60)
  end
end
