require 'webrick'
require 'json'
require 'uri'
require 'net/http'

class Simple < WEBrick::HTTPServlet::AbstractServlet

  MAGIC_PATH = URI.parse("#{ENV['MAGIC_HOST']}/magic")

  def do_GET request, response
    if %w(/ /readiness /liveness /magic /magic-x).member?(request.path_info)
      response.status = 200
      response['Content-Type'] = 'application/json'

      if request.path_info == "/magic"
        data = {data: {service_b: nil}}
        service_b_all_data = JSON.parse(Net::HTTP.get_response(MAGIC_PATH).body)
        endpoint_relevant_data = service_b_all_data["data"]["main"]["answer"]
        data[:data][:service_b] = endpoint_relevant_data
        response.body = data.to_json
      elsif request.path_info == "/magic-x"
        data = {data: {service_b: nil}}
        service_b_all_data = JSON.parse(Net::HTTP.get_response(MAGIC_PATH).body)
        data[:data][:service_b] = service_b_all_data
        response.body = data.to_json
      else
        response.body = "{}"
      end
    else
      response.status = 404
    end
  end
end

server = WEBrick::HTTPServer.new :Port => 8080
server.mount '/', Simple

trap 'INT' do
  server.shutdown
end

server.start

__END__
