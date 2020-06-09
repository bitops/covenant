require 'webrick'
require 'json'

class Simple < WEBrick::HTTPServlet::AbstractServlet

  def do_GET request, response
    if %w(/ /readiness /liveness /magic).member?(request.path_info)
      response.status = 200
      response['Content-Type'] = 'application/json'

      if request.path_info == "/magic"
        data = { data: { main: { answer: "42" } } }
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
