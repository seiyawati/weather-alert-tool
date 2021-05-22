require_relative 'geocode_api_client'
require_relative '../exceptions/exceptions'

class Location
  include Exceptions

  attr_reader :latitude, :longitude

  def self.generated_from(address)
    results = GeocodeAPIClient.new(address).get_request
    raise GeocodeAPIError, "#{results['error_message']}" if results['status'] != 'OK'

    new(
      results['results'][0]['geometry']['location']['lat'],
      results['results'][0]['geometry']['location']['lng']
    )
  end

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end
end
