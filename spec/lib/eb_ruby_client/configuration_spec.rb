require 'eb_ruby_client/configuration'

RSpec.describe EbRubyClient::Configuration do
  subject(:configuration) { EbRubyClient::Configuration.new }

  before do
    config_file_path = File.expand_path("../../../config/eventbrite.yml", __FILE__)
    EbRubyClient::Configuration.config_file_path = config_file_path
  end

  it "returns the base_url" do
    expect(configuration.base_url).to eq("https://test.eventbrite.url/api")
  end

  it "returns the auth_token" do
    expect(configuration.auth_token).to eq("test-auth-token")
  end
end
