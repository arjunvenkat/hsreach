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

  def acceptance_chance?(total_score, tier)
    needed_points = avg_score(tier) - total_score
    if needed_points < 225
      return "high"
    elsif needed_points < 285
      return "medium"
    elsif needed_points < 300
      return "low"
    else
      return "no"
    end
  end

  def avg_score(tier)
    return self.send("tier#{tier}_score")
  end



  # scores = []
  # scores << nwea_math_score = (params['nwea_math'].to_i*1.515).round(0)
  # scores << nwea_reading_score = (params['nwea_reading'].to_i*1.515).round(0)
  # scores << reading_score = grade_conv[params['reading'][0].downcase]
  # scores << math = grade_conv[params['math'][0].downcase]
  # scores << science = grade_conv[params['science'][0].downcase]
  # scores << social_studies = grade_conv[params['social_studies'][0].downcase]

end
