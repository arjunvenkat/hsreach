require 'open-uri'
require 'json'

class PagesController < ApplicationController

  def home
  end

  def get_tier
    session[:nwea_math] = params[:nwea_math].present? ? params[:nwea_math] : session[:nwea_math]
    session[:nwea_reading] = params[:nwea_reading].present? ? params[:nwea_reading] : session[:nwea_reading]
    session[:math] = params[:math].present? ? params[:math] : session[:math]
    session[:reading] = params[:reading].present? ? params[:reading] : session[:reading]
    session[:science] = params[:science].present? ? params[:science] : session[:science]
    session[:social_studies] = params[:social_studies].present? ? params[:social_studies] : session[:social_studies]
  end

  def results
    if user_signed_in?
      snapshot = Snapshot.new
      snapshot.user_id = current_user.id
      snapshot.nwea_math = session[:nwea_math]
      snapshot.nwea_reading = session[:nwea_reading]
      snapshot.math = session[:math]
      snapshot.reading = session[:reading]
      snapshot.science = session[:science]
      snapshot.social_studies = session[:social_studies]
      if current_user.snapshots.last
        if (Time.now - current_user.snapshots.last.updated_at > 1.day)
          snapshot.save
        end
      else
        snapshot.save
      end
    end

    @tier_num = School.sanitize_tier_input(params[:tier_num])
    @total_score = School.total_score_for(session[:nwea_math],
                                          session[:nwea_reading],
                                          session[:math],
                                          session[:reading],
                                          session[:science],
                                          session[:social_studies])
    @map_score = School.map_score_for(session[:nwea_math], session[:nwea_reading])
    full_list = School.all.select do |school|
      school.acceptance_chance(@total_score, @map_score, @tier_num) == "high"
    end
    @schools = full_list.sort_by { |school| school.rating }.take(10)
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(params[:address])}"
    response = open(url).read
    parsed = JSON.parse(response)
    @lat = parsed['results'][0]['geometry']['location']['lat']
    @lng = parsed['results'][0]['geometry']['location']['lng']
  end

end
