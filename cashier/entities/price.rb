module Entities
  class Price < T::Struct
    const :cents, Integer
    const :currency, String
  end
end