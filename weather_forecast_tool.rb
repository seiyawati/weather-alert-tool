require 'json'
require 'date'
require_relative 'classes/openweathermap_api_client'
require_relative 'classes/weather_forecast'

class WeatherForecastTool

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

  def self.usage
    puts <<~TEXT
      ~~~~~~~~~~~~~~~~~~~~~~使い方~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      第1引数：出発地点の住所（ex. 東京都世田谷区松原）
      第2引数：出先の住所（ex. 東京都港区六本木）
      第3引数：外出予定時間（ex. 9時間）時単位で入力してください。
    TEXT
  end

  private

  def display_now_weather_forecast
    <<~TEXT
      --------------------------------------------------------------------------
      #{@current_location}の現在の天候（現在地）
      天気：#{@current_location_weather_forecast.now_weather_condition}
      天気詳細：#{@current_location_weather_forecast.now_weather_condition_detail}
      --------------------------------------------------------------------------
      #{@destination}の現在の天候（出先）
      天気：#{@destination_weather_forecast.now_weather_condition}
      天気詳細：#{@destination_weather_forecast.now_weather_condition_detail}
      --------------------------------------------------------------------------
    TEXT
  end

  def alert_laundry
    @current_location_weather_forecast.hourly_weather_conditions.each_with_index do |weather_condition, i|

      next if ['Clear', 'Clouds'].include?(weather_condition['weather'][0]['main'])

      return if i == @forecast_time

      return "これから天候が悪化するので洗濯物を回収してから出掛けましょう！"
    end
    return
  end

  def alert_umbrella
    @destination_weather_forecast.hourly_weather_conditions.each_with_index do |weather_condition, i|

      next if ['Clear', 'Clouds'].include?(weather_condition['weather'][0]['main'])

      return if i == @forecast_time

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
  return WeatherForecastTool.usage if ARGV[0] == 'help'

  weather_forecast_tool = WeatherForecastTool.new(ARGV[0], ARGV[1], ARGV[2].to_i)
  weather_forecast_tool.run
end
