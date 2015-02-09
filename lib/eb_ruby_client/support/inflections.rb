module EbRubyClient
  module Support
    module Inflections
      def singularize(word)
        if word.end_with?("ses")
          word[0..-3]
        elsif word.end_with?("ies")
          word[0..-4] + "y"
        elsif word.end_with?("s")
          word[0..-2]
        else
          word
        end
      end

      def classify(word)
        word.gsub(/(\A|_)[a-z]/) do |word_start|
          word_start[-1].upcase
        end
      end
    end
  end
end
