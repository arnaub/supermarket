# typed: strict

require_relative './item'
module Cashier
  module Entities
    # Struct to represent a Rule
    class Rule < T::Struct
      const :code, String
      const :evaluate, T.proc.params(items: T::Array[Entities::Item]).returns(Integer)
    end
  end
end
