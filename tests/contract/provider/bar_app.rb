class BarApp
  def call env
    status = 200
    headers = {'Content-Type' => 'application/json'}
    body = {
      "data": {
        "main": {
          "answer" => "99"
        }
      }
    }.to_json
    [status, headers, [body]]
  end
end
