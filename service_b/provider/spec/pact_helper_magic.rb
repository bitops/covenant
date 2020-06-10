require_relative '../magic.rb'

Pact.configuration.reports_dir = "./provider/reports"

Pact.service_provider "Magic" do
  app { Magic.new }
  app_version '1.2.3'
  publish_verification_results !!ENV['PUBLISH_VERIFICATIONS_RESULTS']

  honours_pact_with 'Foo' do
    pact_uri './consumer/spec/support/service-a_service_b.json'
  end
end
