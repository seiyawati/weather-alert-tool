require 'json'
require_relative 'openweathermap_api_client'

class WeatherForecast

  WEATHER_LANGUAGE_SUPPORT = {
    Thunderstorm: '雷雨',
    Drizzle: '霧雨',
    Rain: '雨',
    Snow: '雪',
    Clear: '晴れ',
    Clouds: '曇',
    Mist: '靄',
    Smoke: '煙',
    Haze: '霞',
    Dust: 'ほこり',
    Fog: '霧',
    Sand: '砂',
    Ash: '灰',
    Squall: 'スコール',
    Tornado: '竜巻'
  }

  def initialize(address)
    @response_openweathermap_api = OpenweathermapAPIClient.new(address).response_openweathermap_api
  end

  def parse_response_openweathermap_api
    JSON.parse(@response_openweathermap_api)
  end

  def now_weather_condition
    WEATHER_LANGUAGE_SUPPORT[parse_response_openweathermap_api["current"]["weather"][0]["main"].to_sym]
  end

  def now_weather_condition_detail
    parse_response_openweathermap_api["current"]["weather"][0]["description"]
  end

  def hourly_weather_conditions
    parse_response_openweathermap_api["hourly"]
  end
end
