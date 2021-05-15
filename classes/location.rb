require 'json'
require_relative 'geocode_api_client'

class Location

  attr_reader :latitude, :longitude

  def initialize(response_geocode_api)
    @latitude = JSON.parse(response_geocode_api)['results'][0]['geometry']['location']['lat']
    @longitude = JSON.parse(response_geocode_api)['results'][0]['geometry']['location']['lng']
  end
end
