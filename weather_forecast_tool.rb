require "json"
require 'uri'
require "open-uri"
require "date"
require_relative "config"
require_relative "classes/geocoding"
require_relative "classes/openweathermap"
require_relative "classes/weather_forecast"

current_location = ARGV[0]
destination = ARGV[1]
forecast_time = ARGV[2].to_i

class WeatherForecastTool

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

  def initialize(current_location, destination, forecast_time)
    @current_location = current_location
    @current_location_weather_forecast = WeatherForecast.new(current_location)
    @destination = destination
    @destination_weather_forecast = WeatherForecast.new(destination)
    @forecast_time = forecast_time
  end

  def run
    puts <<~TEXT
      #{Time.now.strftime("%Y年%m月%d日,%H時%M分%S秒")}, 現在時刻の天気予報です。
      #{display_now_weather_forecast}
      注意事項！
      #{display_alert}
    TEXT
  end

  private

  def display_now_weather_forecast
    <<~TEXT
      --------------------------------------------------------------------------
      #{@current_location}の現在の天候（現在地）
      天気：#{WEATHER_LANGUAGE_SUPPORT[@current_location_weather_forecast.now_weather_condition.to_sym]}
      天気詳細：#{@current_location_weather_forecast.now_weather_condition_detail}
      --------------------------------------------------------------------------
      #{@destination}の現在の天候（出先）
      天気：#{WEATHER_LANGUAGE_SUPPORT[@destination_weather_forecast.now_weather_condition.to_sym]}
      天気詳細：#{@destination_weather_forecast.now_weather_condition_detail}
      --------------------------------------------------------------------------
    TEXT
  end

  def alert_laundry
    @current_location_weather_forecast.hourly_weather_conditione_list.each_with_index do |weather_conditione, i|

      next if ['Clear', 'Clouds'].include?(weather_conditione)

      break if i == @external_time

      return "これから天候が悪化するので洗濯物を回収してから出掛けましょう！"
    end
    return
  end

  def alert_umbrella
    @destination_weather_forecast.hourly_weather_conditione_list.each_with_index do |weather_conditione, i|

      next if ['Clear', 'Clouds'].include?(weather_conditione)

      break if i == @external_time

      return "出先で天候が悪化するので傘を持って出掛けましょう！"
    end
    return
  end

  def display_alert
    if alert_laundry || alert_umbrella
      <<~TEXT
        --------------------------------------------------------------------------
        #{alert_laundry}
        #{alert_umbrella}
        --------------------------------------------------------------------------
      TEXT
    else
      <<~TEXT
        --------------------------------------------------------------------------
        特に注意事項はありません。
        現在の天気をチェックして出掛けましょう。
        --------------------------------------------------------------------------
      TEXT
    end
  end
end

if __FILE__ == $0
  weather_alert_tool = WeatherForecastTool.new(current_location, destination, forecast_time)
  weather_alert_tool.run
end
