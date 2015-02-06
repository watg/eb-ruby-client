require 'eb_ruby_client/support/members'
require 'eb_ruby_client/resource/user'

RSpec.describe EbRubyClient::Support::Members do
  class MemberTest
    include EbRubyClient::Support::Members
    extend EbRubyClient::Support::MembersClassMethods

    contains_many :users
  end

  subject(:test_class) { MemberTest.new }

  describe "resource_for" do
    it "returns the correct resource class" do
      expect(test_class.resource_for(:users)).to eq(EbRubyClient::Resource::User)
    end
  end

  describe "set_members" do
    let(:user) { double(EbRubyClient::Resource::User) }

    before do
      allow(EbRubyClient::Resource::User).to receive(:new).and_return(user)
    end

    it "creates members that exist" do
      test_class.set_members({users: [:user1, :user2]})
      expect(EbRubyClient::Resource::User).to have_received(:new).with(:user1)
      expect(EbRubyClient::Resource::User).to have_received(:new).with(:user2)
    end

    it "converts from symbols" do
      test_class.set_members({"users" => [:user1]})
      expect(EbRubyClient::Resource::User).to have_received(:new).with(:user1)
    end

    it "assigns the members" do
      test_class.set_members({users: [:user1, :user2]})
      expect(test_class.users).to eq([user, user])
    end

    it "skips members that don't exist" do
      expect {
        test_class.set_members({unknown: [1]})
      }.not_to raise_error
    end
  end

  describe "contains_many" do
    it "creates an accessor" do
      expect(test_class).to respond_to(:users)
    end

    it "sets the member names" do
      expect(MemberTest.member_names).to eq([:users])
    end
  end
end
