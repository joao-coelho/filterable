class Property < ApplicationRecord
  enum :property_type, [ :apartment, :detached_house ]

  def self.filters
    {
      property_type: :enum_list,
      price: :range,
      size: :excl_range,
      bedrooms: :gt_or_eq,
      published_at: :lt_or_eq,
      bathrooms: :match,
      sold: :not
    }
  end

  include Filterable
end
