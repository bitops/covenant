require 'json'
require 'uri'
require 'net/http'

class BackendService
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
