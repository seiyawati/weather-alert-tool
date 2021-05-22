require_relative '../config'
require_relative 'location'
require_relative 'api_client'

class OpenweathermapAPIClient < APIClient
  def self.generated_from(address)
    new(Location.generated_from(address))
  end

  def initialize(location)
    @location = location
    @base_url = "http://api.openweathermap.org/data/2.5/onecall"
  end

  private

  def request_parameters
    "?lat=#{@location.latitude}&lon=#{@location.longitude}&lang=ja&APPID=#{WEATHER_API_KEY}"
  end
end
