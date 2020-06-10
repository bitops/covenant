require 'faraday'
require 'pact/consumer/rspec'
require_relative 'pact_helper'

describe "Service B client", :pact => true do
  it "can retrieve a thing"  do
    service_b.
      upon_receiving("a retrieve thing request").with({
      method: :get,
      path: '/magic',
      headers: {'Accept' => 'application/json'}
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

    bar_response = Faraday.get(service_b.mock_service_base_url + "/magic", nil, {'Accept' => 'application/json'})

    expect(bar_response.status).to eql 200
    expect(bar_response.body).to eql '{"data":{"main":{"answer":"42"}}}'
  end
end
