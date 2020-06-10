require 'pact/consumer/rspec'

Pact.configuration.pact_dir = File.dirname(__FILE__) + "/pacts"

Pact.service_consumer "Service A" do
  has_pact_with "Service B" do
    mock_service :service_b do
      pact_specification_version "2"
      port 4638
    end
  end
end
