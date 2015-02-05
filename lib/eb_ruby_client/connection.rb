require 'json'

require 'eb_ruby_client/exceptions'

module EbRubyClient
  class Connection
    attr_reader :base_url, :auth_token

    def initialize(configuration:)
      @base_url = configuration.base_url
      @auth_token = configuration.auth_token
    end

    def get(path)
      send_request(full_path_for(path)) do |uri|
        Net::HTTP::Get.new(uri)
      end
    end

    private

    def send_request(path, history = [], &block)
      uri = URI(path)
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        request = yield(uri)
        request["Authorization"] = "Bearer #{auth_token}"

        response = http.request(request)
        check_response(response, path, history, &block)
      end
    end

    def check_response(response, path, history = [], &block)
      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      when Net::HTTPRedirection
        location = response["Location"]
        if history.include?(location)
          raise RedirectionLoop.new(path)
        end
        send_request(location, history + [path], &block)
      else
        body = response.body
        description = if body.nil? || body.empty?
                        ""
                      else
                        JSON.parse(response.body)["error_description"]
                      end
        raise RequestFailure.new(description)
      end
    end

    def full_path_for(path)
      "#{base_url}/#{path}"
    end
  end
end
