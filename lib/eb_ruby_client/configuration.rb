module EbRubyClient
  class Configuration
    def self.config_file_path=(path)
      @@config_file_path = path
    end

    attr_reader :base_url, :auth_token

    def initialize
      config = load_config
      @base_url = config["base_url"]
      @auth_token = config["oauth_token"]
    end

    private

    def load_config
      YAML.load_file(@@config_file_path)
    end
  end
end
