require 'eb_ruby_client/resource/user'

RSpec.describe EbRubyClient::Resource::User do
  let(:data) {{
    "id" => "123",
    "name" => "Betty Person",
    "first_name" => "Betty",
    "last_name" => "Person",
  }}
  subject(:user) { EbRubyClient::Resource::User.new(data) }

  describe "initialize" do
    it "sets the id" do
      expect(user.id).to eq("123")
    end

    it "sets the name" do
      expect(user.name).to eq("Betty Person")
    end

    it "sets the first_name" do
      expect(user.first_name).to eq("Betty")
    end

    it "sets the last_name" do
      expect(user.last_name).to eq("Person")
    end
  end
end
