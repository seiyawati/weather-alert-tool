require 'json'
require 'uri'
require 'open-uri'
require_relative 'location'
require_relative '../config'
require_relative '../exceptions/api_exceptions'

class GeocodeAPIClient

  include APIExceptions

  BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json"

  def initialize(address)
    @address = address
  end

  def response_geocode_api
    open(URI.encode(BASE_URL + "?address=#{@address}&key=" + GOOGLE_API_KEY)).read
  end

  def response_location_data
    result = JSON.parse(response_geocode_api)
    raise GeocodeAPIError, "#{result['error_message']}" if result['status'] != 'OK'

    Location.new(result['results'][0]['geometry']['location']['lat'], result['results'][0]['geometry']['location']['lng'])
  end
end
