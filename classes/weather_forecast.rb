require_relative 'openweathermap_api_client'
require_relative '../exceptions/exceptions'

class WeatherForecast
  include Exceptions

  attr_reader :now_weather_condition, :now_weather_condition_detail, :hourly_weather_conditions

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

  def self.generated_from(address)
    results = OpenweathermapAPIClient.generated_from(address).get_request
    raise OpenweathermapAPIError, "#{results['message']}" if results['status'].to_i != 0

    new(
      results["current"]["weather"][0]["main"],
      results["current"]["weather"][0]["description"],
      results["hourly"]
    )
  end

  def initialize(now_weather_condition, now_weather_condition_detail, hourly_weather_conditions)
    @now_weather_condition = WEATHER_LANGUAGE_SUPPORT[now_weather_condition.to_sym]
    @now_weather_condition_detail = now_weather_condition_detail
    @hourly_weather_conditions = hourly_weather_conditions
  end
end
