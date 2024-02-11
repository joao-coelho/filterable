class Property < ApplicationRecord
  enum :property_type, [ :apartment, :detached_house ]

  def self.filters
    {
      property_type: :list,
      price: :range
    }
  end

  include Filterable
end
