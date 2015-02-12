require 'eb_ruby_client'

RSpec.describe EbRubyClient::Client do
  let(:configuration) { instance_double(EbRubyClient::Configuration) }
  let(:connection) { instance_double(EbRubyClient::Connection) }

  subject(:client) { EbRubyClient::Client.new }

  before do
    allow(EbRubyClient::Configuration).to receive(:new).and_return(configuration)
    allow(EbRubyClient::Connection).to receive(:new).and_return(connection)
  end

  describe "initialize" do
    it "creates a configuration object" do
      client
      expect(EbRubyClient::Configuration).to have_received(:new)
    end

    it "creates a connection with the configuration" do
      client
      expect(EbRubyClient::Connection).to have_received(:new).
        with(configuration: configuration)
    end
  end

  describe "users" do
    it "creates a Users endpoint" do
      users = instance_double(EbRubyClient::Endpoints::Users)
      expect(EbRubyClient::Endpoints::Users).to receive(:new).
        with(connection: connection).and_return(users)
      expect(client.users).to be(users)
    end
  end

  describe "venues" do
    it "creates a Venues endpoint" do
      venues = instance_double(EbRubyClient::Endpoints::Venues)
      expect(EbRubyClient::Endpoints::Venues).to receive(:new).
        with(connection: connection).and_return(venues)
      expect(client.venues).to be(venues)
    end
  end
end
