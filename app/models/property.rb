class Property < ApplicationRecord
  def self.filters
    {
      type: :list,
      price: :range
    }
  end

  include Filterable
end
