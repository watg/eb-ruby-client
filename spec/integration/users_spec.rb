require 'eb_ruby_client/client.rb'

RSpec.describe "users" do
  include RSpec::Fixtures

  subject(:client) { EbRubyClient::Client.new }

  before do
    EbRubyClient::Configuration.config_file_path = File.expand_path("../../config/eventbrite.yml", __FILE__)

    stub_request(:get, "https://test.eventbrite.url/api/users/me").
      to_return(body: fixture("users/me"))
  end

  describe "/me" do
    it "returns the user information" do
      user = client.users.me
      expect(user.id).to eq("123")
      expect(user.name).to eq("Betty Person")
    end
  end
end
