class School < ActiveRecord::Base
  geocoded_by :address, :latitude => :lat, :longitude => :long # ActiveRecord
  after_validation :geocode          # auto-fetch coordinates

  GRADE_CONV = {
    "a" => 75,
    "b" => 50,
    "c" => 25,
    "d" => 0,
    "f" => 0
  }

  def self.sanitize_tier_input(tier_input)
    tier_num = tier_input.downcase
    tier_num.slice! "tier"
    tier_num.slice! "teir"
    tier_num.slice! "teer"
    tier_num.strip[0]
  end

  def self.total_score_for(nwea_math, nwea_reading, math, reading, science, social_studies)
    scores  = []
    scores << (nwea_math.to_i*1.515).round(0)
    scores << (nwea_reading.to_i*1.515).round(0)
    scores << GRADE_CONV[math.downcase.strip[0]]
    scores << GRADE_CONV[reading.downcase.strip[0]]
    scores << GRADE_CONV[science.downcase.strip[0]]
    scores << GRADE_CONV[social_studies.downcase.strip[0]]
    scores.compact.sum
  end

  def self.map_score_for(nwea_math, nwea_reading)
    nwea_math.to_i + nwea_reading.to_i
  end

  def needed_percentage(total_score, tier)
    (needed_points(total_score, tier)*100.0/300).round(0)
  end
end
