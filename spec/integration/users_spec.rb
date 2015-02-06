require 'eb_ruby_client/client.rb'

RSpec.describe "users" do
  include RSpec::Fixtures

  subject(:client) { EbRubyClient::Client.new }

  before do
    EbRubyClient::Configuration.config_file_path = File.expand_path("../../config/eventbrite.yml", __FILE__)

    stub_request(:get, "https://test.eventbrite.url/api/users/me").
      to_return(body: fixture("users/me"))
    stub_request(:get, "https://test.eventbrite.url/api/users/123/organizers").
      to_return(body: fixture("users/organizers"))
  end

  describe "me" do
    it "returns the user information" do
      user = client.users.me
      expect(user.id).to eq("123")
      expect(user.name).to eq("Betty Person")
    end
  end

  describe "organizers" do
    it 'returns some organizers' do
      organizers = client.users.organizers(user_id: 123)
      expect(organizers).to be_an(Array)
      organizer = organizers.first
      expect(organizer.name).to eq("Betty Person")
      expect(organizer.resource_uri).to eq("https://www.eventbriteapi.com/v3/organizers/123/")
      expect(organizer.id).to eq("123")
    end
  end
end
