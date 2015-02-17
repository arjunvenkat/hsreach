class PagesController < ApplicationController

  def home
  end

  def results
    grade_conv = {
      "a" => 75,
      "b" => 50,
      "c" => 25,
      "d" => 0,
      "f" => 0
    }
    scores = []
    scores << nwea_math_score = (params['nwea_math'].to_i*1.515).round(0)
    scores << nwea_reading_score = (params['nwea_reading'].to_i*1.515).round(0)
    scores << reading_score = grade_conv[params['reading'][0].downcase]
    scores << math = grade_conv[params['math'][0].downcase]
    scores << science = grade_conv[params['science'][0].downcase]
    scores << social_studies = grade_conv[params['social_studies'][0].downcase]

    @total_score = scores.sum
    @schools = School.all
  end

end
