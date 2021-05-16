require 'json'
require 'uri'
require 'open-uri'
require_relative '../config'
require_relative '../exceptions/api_exceptions'

class GeocodeAPIClient

  include APIExceptions

  BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json"

  def initialize(address)
    @address = address
  end

  def request_geocode_api
    open(URI.encode(BASE_URL + "?address=#{@address}&key=" + GOOGLE_API_KEY)).read
  end

  def parse_response(response)
    JSON.parse(response)
  end

  def response_status(response)
    parse_response(response)['status']
  end

  def response_geocode_api
    response = request_geocode_api
    raise GeocodeAPIError, "GeocodeAPIから正しい応答がありませんでした。" if response_status(response) != 'OK'

    response
  end
end
