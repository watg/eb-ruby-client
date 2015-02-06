require 'eb_ruby_client/connection'

RSpec.describe EbRubyClient::Connection do
  let(:base_url) { "http://some.url/" }
  let(:token) { "http://some.url/" }
  let(:configuration) { double(:configuration, base_url: base_url, auth_token: token)}

  let(:path) { "some/path" }
  let(:full_path) { "#{base_url}/#{path}"}

  subject(:connection) { EbRubyClient::Connection.new(configuration: configuration) }

  before do
    stub_request(:any, full_path).to_return(status: 200, body: "{}")
  end

  describe "get" do
    it "makes a GET request to full URL" do
      connection.get(path)
      expect(WebMock).to have_requested(:get, full_path)
    end

    context "when the API is using HTTPs" do
      let(:base_url) { "https://some.url/" }

      it "makes an HTTPS request" do
        connection.get(path)
        expect(WebMock).to have_requested(:get, full_path)
      end
    end

    it "adds the authentication header to the request" do
      connection.get(path)
      expect(WebMock).to have_requested(:get, full_path).with(
        headers: {"Authorization" => "Bearer #{token}"}
      )
    end

    context "when the response is success" do
      let(:data) { {"some" => "thing"} }
      let(:body) { data.to_json }

      before do
        stub_request(:get, full_path).to_return(status: 200, body: body)
      end

      it "returns the JSON parsed body" do
        response = connection.get(path)
        expect(response).to eq(data)
      end
    end

    context "when the response is redirection" do
      let(:other_url) { "http://other.url/" }
      let(:data) { {"some" => "thing"} }
      let(:body) { data.to_json }

      before do
        stub_request(:get, full_path).to_return(
          status: 302,
          headers: { "Location" => "http://other.url/"}
        )
        stub_request(:get, other_url).to_return(status: 200, body: body)
      end

      it "follows the redirection" do
        connection.get(path)
        expect(WebMock).to have_requested(:get, full_path).once
        expect(WebMock).to have_requested(:get, other_url).once
      end

      it "returns the JSON parsed body the first successful response" do
        response = connection.get(path)
        expect(response).to eq(data)
      end

      context "when there is a redirection loop" do
        before do
          stub_request(:get, other_url).to_return(
            status: 302,
            headers: { "Location" => full_path}
          )
        end

        it "raises an exception" do
          expect { connection.get(path) }.to raise_error(EbRubyClient::RedirectionLoop)
        end
      end
    end

    context "when the response is an error" do
      before do
        stub_request(:get, full_path).to_return(status: 500, body: "")
      end

      it "raises an exception" do
        expect { connection.get(path) }.to raise_error(EbRubyClient::RequestFailure)
      end

      context "when the response contains an error description" do
        let(:description) { "invalid request" }
        let(:body) { {"error_description" => description}.to_json }

        before do
          stub_request(:get, full_path).to_return(status: 500, body: body)
        end

        it "adds the description to the exception" do
          caught_description = nil
          begin
            connection.get(path)
          rescue EbRubyClient::RequestFailure => e
            caught_description = e.description
          end

          expect(caught_description).to eq(description)
        end
      end
    end
  end














  describe "#post" do
    let(:post_data) { {"one" => "hat", "two" => "scarf"} }

    it "makes a POST request to full URL" do
      connection.post(path, post_data)
      expect(WebMock).to have_requested(:post, full_path).with(body: "one=hat&two=scarf")
    end

    context "when the API is using HTTPs" do
      let(:base_url) { "https://some.url/" }

      it "makes an HTTPS request" do
        connection.post(path, post_data)
        expect(WebMock).to have_requested(:post, full_path).with(body: "one=hat&two=scarf")
      end
    end

    it "adds the authentication header to the request" do
      connection.post(path, post_data)
      expect(WebMock).to have_requested(:post, full_path).with(
        headers: {"Authorization" => "Bearer #{token}"}
      )
    end

    context "when the response is success" do
      let(:data) { {"some" => "thing"} }
      let(:body) { data.to_json }

      before do
        stub_request(:post, full_path).to_return(status: 200, body: body)
      end

      it "returns the JSON parsed body" do
        response = connection.post(path, post_data)
        expect(response).to eq(data)
      end
    end

    context "when the response is redirection" do
      let(:other_url) { "http://other.url/" }
      let(:data) { {"some" => "thing"} }
      let(:body) { data.to_json }

      before do
        stub_request(:post, full_path).to_return(
          status: 302,
          headers: { "Location" => "http://other.url/"}
        )
        stub_request(:post, other_url).to_return(status: 200, body: body)
      end

      it "follows the redirection" do
        connection.post(path, post_data)
        expect(WebMock).to have_requested(:post, full_path).with(body: "one=hat&two=scarf").once
        expect(WebMock).to have_requested(:post, other_url).with(body: "one=hat&two=scarf").once
      end

      it "returns the JSON parsed body the first successful response" do
        response = connection.post(path, post_data)
        expect(response).to eq(data)
      end

      context "when there is a redirection loop" do
        before do
          stub_request(:post, other_url).to_return(
            status: 302,
            headers: { "Location" => full_path}
          )
        end

        it "raises an exception" do
          expect { connection.post(path, post_data) }.to raise_error(EbRubyClient::RedirectionLoop)
        end
      end
    end

    context "when the response is an error" do
      before do
        stub_request(:post, full_path).to_return(status: 500, body: "")
      end

      it "raises an exception" do
        expect { connection.post(path, post_data) }.to raise_error(EbRubyClient::RequestFailure)
      end

      context "when the response contains an error description" do
        let(:description) { "invalid request" }
        let(:body) { {"error_description" => description}.to_json }

        before do
          stub_request(:post, full_path).to_return(status: 500, body: body)
        end

        it "adds the description to the exception" do
          caught_description = nil
          begin
            connection.post(path, post_data)
          rescue EbRubyClient::RequestFailure => e
            caught_description = e.description
          end

          expect(caught_description).to eq(description)
        end
      end
    end
  end
end
