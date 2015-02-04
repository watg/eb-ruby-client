module EbRubyClient
  class RedirectionLoop < StandardError
    def initialize(url)
      @url = url
    end

    def msg
      "Loop detected when fetching #{@url}"
    end
  end

  class RequestFailure < StandardError
    attr_reader :description

    def initialize(description = "")
      @description = description
    end

    def message
      @description || "Request failed"
    end
  end
end
