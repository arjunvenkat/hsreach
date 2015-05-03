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

  def needed_points(total_score, tier)
    puts "#{name} #{tier}"
    if category == "selective" || category == "IB"
      points = avg_score(tier) - total_score
      return points > 0  ? points : 0
    elsif category == "military"
      return 0
    end
  end

  def needed_percentage(total_score, tier)
    (needed_points(total_score, tier)*100.0/300).round(0)
  end

  def acceptance_chance(total_score, map_score, tier)
    if category == "selective" || category == "IB"
      points = needed_points(total_score, tier)
      if points < 225
        return "high"
      elsif points < 285
        return "medium"
      elsif points < 300
        return "low"
      else
        return "no"
      end
    elsif category == "military"
      if map_score > 48
        return "high"
      else
        return "low"
      end
    end
  end

  def avg_score(tier)
    if category == "selective" || category == "IB"
      return self.send("tier#{tier}_score")
    elsif category == "military"
      return 0
    end
  end

end
