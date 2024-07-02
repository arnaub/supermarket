# typed: strict

require_relative "./price"
module Cashier
  module Entities
    # Struct to represent an Item
    class Item < T::Struct
      const :code, String
      const :name, String
      const :price, Cashier::Entities::Price
    end
  end
end
