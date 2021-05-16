require "json"
require "open-uri"
require_relative "../config"
require_relative "location"

class OpenweathermapAPIClient

  include APIExceptions

  BASE_URL = "http://api.openweathermap.org/data/2.5/onecall"

  def initialize(address)
    @location = Location.new(address)
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

  def response_openweathermap_api
    response = request_openweathermap_api
    raise OpenweathermapAPIError, "OpenweathermapAPIから正しい応答がありませんでした。" if response_status(response) != 0
    
    response
  end
end
