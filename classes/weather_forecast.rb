class WeatherForecast

  def initialize(address)
    @openweathermap_api_response = Openweathermap.new(address).response_openweathermap_api
  end

  def now_weather_condition
    JSON.parse(@openweathermap_api_response)["current"]["weather"][0]['main']
  end

  def now_weather_condition_detail
    JSON.parse(@openweathermap_api_response)["current"]["weather"][0]['description']
  end

  def hourly_weather_conditiones
    JSON.parse(@openweathermap_api_response)["hourly"]
  end

  def hourly_weather_conditione_list
    hourly_weather_conditiones.map { |hourly_weather_conditione|
      hourly_weather_conditione['weather'][0]['main']
    }
  end
end
