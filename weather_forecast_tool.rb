require 'json'
require 'date'
require_relative 'classes/weather_forecast'
require_relative 'exceptions/exceptions'

class WeatherForecastTool
  include Exceptions

  def self.usage
    puts <<~TEXT
      ~~~~~~~~~~~~~~~~~~~~~~使い方~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      第1引数：出発地点の住所（ex. 東京都世田谷区松原）
      第2引数：出先の住所（ex. 東京都港区六本木）
      第3引数：外出予定時間（ex. 9）時単位で入力してください。
    TEXT
  end

  def initialize(current_location, destination, forecast_time)
    @current_location = current_location
    @destination = destination
    @forecast_time = forecast_time
  end

  def run
    forecast
    display_now_weather_forecast
    display_alert
  end

  private

  def forecast
    @current_location_weather_forecast = WeatherForecast.generated_from(@current_location)
    @destination_weather_forecast = WeatherForecast.generated_from(@destination)
  end

  def now_time
    "#{Time.now.strftime("%Y年%m月%d日,%H時%M分")}, 現在時刻の天気予報です。"
  end

  def display_now_weather_forecast
    puts <<~TEXT
      #{now_time}
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
    if ['晴れ', '曇'].include?(@current_location_weather_forecast.now_weather_condition)
      @current_location_weather_forecast.hourly_weather_conditions.each_with_index do |weather_condition, i|

        next if ['Clear', 'Clouds'].include?(weather_condition['weather'][0]['main'])

        break if i == @forecast_time

        return "これから天候が悪化するので洗濯物を回収してから出掛けましょう！"
      end
    end
  end

  def alert_umbrella
    if ['晴れ', '曇'].include?(@destination_weather_forecast.now_weather_condition)
      @destination_weather_forecast.hourly_weather_conditions.each_with_index do |weather_condition, i|

        next if ['Clear', 'Clouds'].include?(weather_condition['weather'][0]['main'])

        break if i == @forecast_time

        return "出先で天候が悪化するので傘を持って出掛けましょう！"
      end
    end
  end

  def display_alert
    if alert_laundry || alert_umbrella
      puts <<~TEXT
        注意事項！
        --------------------------------------------------------------------------
        #{alert_laundry}
        #{alert_umbrella}
        --------------------------------------------------------------------------
      TEXT
    else
      puts <<~TEXT
        注意事項！
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

  raise ArgumentError, 'コマンドライン引数の数が正しくありません。' if ARGV.length != 3

  weather_forecast_tool = WeatherForecastTool.new(ARGV[0], ARGV[1], ARGV[2].to_i)
  weather_forecast_tool.run
end
