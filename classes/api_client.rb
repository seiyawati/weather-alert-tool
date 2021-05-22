require 'json'
require 'uri'
require 'open-uri'

class APIClient
  def initialize
    @base_url = ''
  end

  def get_request
    JSON.parse(
      open(request_url).read
    )
  end

  private

  def request_url
    URI.encode(@base_url + request_parameters)
  end
end
