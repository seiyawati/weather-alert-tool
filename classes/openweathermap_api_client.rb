require "open-uri"
require "json"
require_relative "../config"
require_relative "location"
require_relative "geocode_api_client"

class OpenweathermapAPIClient

  BASE_URL = "http://api.openweathermap.org/data/2.5/onecall"

  def initialize(address)
    @location = Location.new(GeocodeAPIClient.new(address).response_geocode_api)
  end

  def request_openweathermap_api
    open(BASE_URL + "?lat=#{@location.latitude}&lon=#{@location.longitude}&lang=ja&APPID=#{WEATHER_API_KEY}").read
  end

  def parse_response(response)
    JSON.parse(response)
  end

  def response_status(response)
    parse_response(response)['status'].to_i
  end

  def response_message(response)
    parse_response(response)['message']
  end

  def response_openweathermap_api
    response = request_openweathermap_api
    if response_status(response) != 0
      raise "#{response_message(response)}"
    end
    response
  end
end
