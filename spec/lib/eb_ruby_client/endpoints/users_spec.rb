require 'eb_ruby_client/connection'
require 'eb_ruby_client/endpoints/users'

RSpec.describe EbRubyClient::Endpoints::Users do
  let(:connection) { instance_double(EbRubyClient::Connection) }
  subject(:users) { EbRubyClient::Endpoints::Users.new(connection: connection) }

  describe "me" do
    let(:response) { {"id" => "123"} }

    before do
      allow(connection).to receive(:get).and_return(response)
    end

    it "makes a GET request to API endpoint" do
      users.me
      expect(connection).to have_received(:get).with("users/me")
    end

    it "returns a User resource" do
      user = double(EbRubyClient::Resource::User)
      expect(EbRubyClient::Resource::User).to receive(:new).with(response).and_return(user)
      expect(users.me).to be(user)
    end
  end
end
