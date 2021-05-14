class Openweathermap

  BASE_URL = "http://api.openweathermap.org/data/2.5/onecall"

  def initialize(address)
    @response_geocoding_api = Geocoding.new(address).response_geocoding_api
  end

  def latitude
    JSON.parse(@response_geocoding_api)['results'][0]['geometry']['location']['lat']
  end

  def longnitude
    JSON.parse(@response_geocoding_api)['results'][0]['geometry']['location']['lng']
  end

  def request_openweathermap_api
    open(BASE_URL + "?lat=#{latitude}&lon=#{longnitude}&lang=ja&APPID=#{WEATHER_API_KEY}").read
  end

  def response_status(response)
    JSON.parse(response)['status'].to_i
  end

  def response_message(response)
    JSON.parse(response)['message']
  end

  def response_openweathermap_api
    response = request_openweathermap_api
    if response_status(response) != 0
      raise "#{response_message(response)}"
    end
    response
  end
end
