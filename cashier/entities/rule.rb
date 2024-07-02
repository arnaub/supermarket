module Entities
  class Rule < T::Struct
    const :code, String
    const :evaluate, T.proc.params(items: T::Array[Entities::Item]).returns(Integer)
  end
end