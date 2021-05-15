require 'json'
require_relative 'geocode_api_client'

class Location

  def initialize(address)
    @response_geocode_api = GeocodeAPIClient.new(address).response_geocode_api
  end

  def parse_response_geocode_api
    JSON.parse(@response_geocode_api)
  end

  def latitude
    parse_response_geocode_api['results'][0]['geometry']['location']['lat']
  end

  def longitude
    parse_response_geocode_api['results'][0]['geometry']['location']['lng']
  end
end
