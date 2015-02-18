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
    @tier_num = School.sanitize_tier_input(params[:tier_num])
    @total_score = School.total_score_for(session[:nwea_math],
                                          session[:nwea_reading],
                                          session[:math],
                                          session[:reading],
                                          session[:science],
                                          session[:social_studies])
    @schools = School.all
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(params[:address])}"
    response = open(url).read
    parsed = JSON.parse(response)
    @lat = parsed['results'][0]['geometry']['location']['lat']
    @lng = parsed['results'][0]['geometry']['location']['lng']
  end

end
