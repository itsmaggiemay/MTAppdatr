require 'rest_client'

class Datumbox

  BASE_URI = 'http://api.datumbox.com/'
  API_VERSION = '1.0'

  def initialize
    @api_key = ENV['DATUMBOX_API_KEY']
  end

  def self.create(api_key)
    Datumbox.new(api_key)
  end

  def request(method, opts)
    options = { api_key: @api_key }.merge opts
    RestClient.post "#{BASE_URI}#{API_VERSION}/#{method}.json", options
  end

  def method_missing(method_id, opts, &block)
    begin
      response = request(method_id, opts)
      response_parsed = JSON(response)
        result = response_parsed["output"]["result"]
        #result is neg or positive
        return result

    end
  end

end
