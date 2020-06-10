require 'webrick'
require 'json'
require_relative './backend_service'

class Simple < WEBrick::HTTPServlet::AbstractServlet

  BACKEND_SERVICE = BackendService.new(ENV['MAGIC_HOST'])

  def do_GET request, response
    if %w(/ /readiness /liveness /magic /magic-x).member?(request.path_info)
      response.status = 200
      response['Content-Type'] = 'application/json'

      if request.path_info == "/magic"
        data = {data: {service_b: nil}}
        service_b_all_data = BACKEND_SERVICE.magic
        data[:data][:service_b] = service_b_all_data["data"]["main"]["answer"]
        response.body = data.to_json
      elsif request.path_info == "/magic-x"
        data = {data: {service_b: nil}}
        data[:data][:service_b] = BACKEND_SERVICE.magic
        response.body = data.to_json
      elsif request.path_info == "/readiness"
        magic_host = ENV['MAGIC_HOST']
        if magic_host.nil? || magic_host.empty?
          response.status = 400
        end
        response.body = "{}"
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
