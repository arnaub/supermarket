# typed: strict

module Entities
  class Item < T::Struct
    const :code, String
    const :name, String
    const :price, Entities::Price
  end
end