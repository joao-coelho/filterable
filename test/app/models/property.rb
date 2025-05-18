class Property < ApplicationRecord
  enum :property_type, [:apartment, :detached_house]

  def self.filters
    {
      property_type: :enum_list,
      price: :range,
      size: :lt_or_eq,
      bedrooms: :excl_range,
      published_at: :gt_or_eq,
      bathrooms: :match,
      sold: :not
    }
  end

  include Filterable
end
