require 'eb_ruby_client/support/members'
require 'eb_ruby_client/resource/user'
require 'eb_ruby_client/resource/address'

RSpec.describe EbRubyClient::Support::Members do
  class MemberTest
    include EbRubyClient::Support::Members
    extend EbRubyClient::Support::MembersClassMethods

    contains_many :users
    contains_one :address
  end

  subject(:test_class) { MemberTest.new }

  describe "resource_for" do
    it "returns the correct resource class" do
      expect(test_class.resource_for("user")).to eq(EbRubyClient::Resource::User)
    end
  end

  describe "set_members" do
    let(:user) { double(EbRubyClient::Resource::User) }
    let(:address) { double(EbRubyClient::Resource::Address) }

    before do
      allow(EbRubyClient::Resource::User).to receive(:new).and_return(user)
      allow(EbRubyClient::Resource::Address).to receive(:new).and_return(address)
    end

    it "skips members that don't exist" do
      expect {
        test_class.set_members({unknown: [1]})
      }.not_to raise_error
    end

    context "with contains_many" do
      it "creates members that exist" do
        test_class.set_members({"users" => [:user1, :user2]})
        expect(EbRubyClient::Resource::User).to have_received(:new).with(:user1)
        expect(EbRubyClient::Resource::User).to have_received(:new).with(:user2)
      end

      it "assigns the members" do
        test_class.set_members({"users" => [:user1, :user2]})
        expect(test_class.users).to eq([user, user])
      end
    end

    context "with contains_one" do
      it "creates a member that exists" do
        test_class.set_members({"address" => :address})
        expect(EbRubyClient::Resource::Address).to have_received(:new).with(:address)
      end

      it "assigns the member" do
        test_class.set_members("address" => :address)
        expect(test_class.address).to eq(address)
      end
    end
  end

  describe "contains_many" do
    it "creates an accessor" do
      expect(test_class).to respond_to(:users)
      expect(test_class).to respond_to(:users=)
    end

    it "sets the multiple member names" do
      expect(MemberTest.multiple_member_names).to eq([:users])
    end
  end

  describe "contains_one" do
    it "creates an accessor" do
      expect(test_class).to respond_to(:address)
      expect(test_class).to respond_to(:address=)
    end

    it "sets the member names" do
      expect(MemberTest.singular_member_names).to eq([:address])
    end
  end
end
