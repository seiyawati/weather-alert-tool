require 'json'
require 'uri'
require 'open-uri'

class GeocodeAPIClient

  BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json"

  def initialize(address)
    @address = address
  end

  def request_geocode_api
    open(URI.encode(BASE_URL + "?address=#{@address}&key=" + GOOGLE_API_KEY)).read
  end

  def parse_response(response)
    JSON.parse(response)
  end

  def response_status(response)
    parse_response(response)['status']
  end

  def response_geocode_api
    response = request_geocode_api
    if response_status(response) != 'OK'
      raise "#{response_status(response)}：緯度経度の取得に失敗しました。"
    end
    response
  end
end
