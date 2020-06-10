require 'faraday'
require 'pact/consumer/rspec'
require_relative '../backend_client'

Pact.configuration.pact_dir = File.dirname(__FILE__) + "/pacts"

Pact.service_consumer "Service A" do
  has_pact_with "Service B" do
    mock_service :service_b do
      pact_specification_version "2"
      port 4638
    end
  end
end

describe "Service B client", :pact => true do
  it "gets some magic"  do
    service_b.
      upon_receiving("some magic").with({
      method: :get,
      path: '/magic'
    }).
      will_respond_with({
      status: 200,
      headers: { 'Content-Type' => 'application/json' },
      body: {
        data: {
          main: {
            answer: Pact.like("42"),
          }
        }
      }
    })

    bar_response = BackendClient.new(service_b.mock_service_base_url).magic
    expect(bar_response["data"]["main"]["answer"]).to eql "42"
  end

end
