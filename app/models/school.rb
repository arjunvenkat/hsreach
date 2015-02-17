class School < ActiveRecord::Base
  geocoded_by :address, :latitude  => :lat, :longitude => :long # ActiveRecord
  after_validation :geocode          # auto-fetch coordinates
end
