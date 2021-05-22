require_relative '../config'
require_relative 'api_client'

class GeocodeAPIClient < APIClient
  def initialize(address)
    @address = address
    @base_url = "https://maps.googleapis.com/maps/api/geocode/json"
  end

  private

  def request_parameters
    "?address=#{@address}&key=#{GOOGLE_API_KEY}"
  end
end
