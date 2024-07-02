# typed: strict

require_relative '../entities/item'

module Cashier
  module Rules
    # The Rule class is an abstract class representing a generic pricing rule in the Cashier system.
    class Rule
      extend T::Sig
      extend T::Helpers

      abstract!

      sig { abstract.params(items: T::Array[Entities::Item]).returns(Integer) }
      def self.evaluate(items); end

      sig { abstract.returns(String) }
      def self.code; end
    end
  end
end
