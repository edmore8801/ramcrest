require 'ramcrest/match'

module Ramcrest
  module Is
    def self.to_matcher(possible_matcher)
      return possible_matcher if Ramcrest.is_matcher?(possible_matcher)
      Ramcrest::Is.is(possible_matcher)
    end

  module_function

    def is(expected)
      Matcher.new(Ramcrest::EqualTo.to_matcher(expected))
    end

    class Matcher
      include Ramcrest::Match

      def initialize(expected)
        @expected = expected
      end

      def do_match(actual)
        @expected.matches?(actual)
      end

      def mismatch_message(actual, match)
        "was <#{match.description}>"
      end

      def description
        "is <#{@expected.description}>"
      end

      def matches?(actual)
        match = do_match(actual)
        if match.matched?
          success
        else
          mismatch(mismatch_message(actual, match))
        end
      end
    end
  end
end
