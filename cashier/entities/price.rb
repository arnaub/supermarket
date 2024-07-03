# typed: strict
module Cashier
  module Entities
    # Struct to represent the Price
    class Price < T::Struct
      const :cents, Integer
      const :currency, String
    end
  end
end
