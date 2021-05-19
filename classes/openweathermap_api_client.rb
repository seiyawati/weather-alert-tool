require 'json'
require 'open-uri'
require_relative 'geocode_api_client'
require_relative 'weather_forecast'
require_relative '../config'
require_relative '../exceptions/api_exceptions'

class OpenweathermapAPIClient

  include APIExceptions

  BASE_URL = "http://api.openweathermap.org/data/2.5/onecall"

  def initialize(address)
    @location = GeocodeAPIClient.new(address).response_location_data
  end

  def response_openweathermap_api
    open(BASE_URL + "?lat=#{@location.latitude}&lon=#{@location.longitude}&lang=ja&APPID=#{WEATHER_API_KEY}").read
  end

  def response_weather_forecast_data
    result = JSON.parse(response_openweathermap_api)
    raise OpenweathermapAPIError, "#{result['message']}" if result['status'].to_i != 0

    WeatherForecast.new(result["current"]["weather"][0]["main"], result["current"]["weather"][0]["description"], result["hourly"])
  end
end
