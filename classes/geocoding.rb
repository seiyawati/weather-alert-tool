class Geocoding

  BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json"

  def initialize(address)
    @address = address
  end

  def request_geocoding_api
    open(URI.encode(BASE_URL + "?address=#{@address}&key=" + GOOGLE_API_KEY)).read
  end

  def response_status(response)
    JSON.parse(response)['status']
  end

  def response_geocoding_api
    response = request_geocoding_api
    if response_status(response) != 'OK'
      raise "#{response_status}：緯度経度の取得に失敗しました。"
    end
    response
  end
end
