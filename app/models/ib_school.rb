class IbSchool < School
  def needed_points(total_score, tier)
    points = avg_score(tier) - total_score
    return points > 0  ? points : 0
  end

  def acceptance_chance(total_score, map_score, tier)
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
  end

  def avg_score(tier)
    return self.send("tier#{tier}_score")
  end
end
