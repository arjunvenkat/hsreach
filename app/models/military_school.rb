class MilitarySchool < School
  def needed_points(total_score, tier)
      return 0
  end

  def acceptance_chance(total_score, map_score, tier)
    if map_score > 48
      return "high"
    else
      return "low"
    end
  end

  def avg_score(tier)
    return 0
  end
end
