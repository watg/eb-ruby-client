module RSpec
  module Fixtures
    def fixture(path)
      path = File.join(fixtures_dir, path)
      File.read(path)
    end

    private

    def fixtures_dir
      @fixtures_dir ||= File.expand_path("../../fixtures", __FILE__)
    end
  end
end
