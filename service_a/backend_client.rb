require 'json'
require 'uri'
require 'net/http'

class BackendClient
  def initialize(host)
    @host = host
  end

  def magic
    JSON.parse(Net::HTTP.get_response(magic_path).body)
  end

  private
  def magic_path
    URI.parse("#{@host}/magic")
  end
end
