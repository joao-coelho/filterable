# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
properties = Property.create([
  {
    price: 259000.0,
    property_type: :apartment,
    size: 100,
    bedrooms: 2,
    bathrooms: 1,
    sold: false,
    published_at: DateTime.new(2025, 2, 7)
  },
  {
    price: 345990.0,
    property_type: :detached_house,
    size: 259,
    bedrooms: 4,
    bathrooms: 3,
    sold: false,
    published_at: DateTime.new(2025, 1, 31)
  },
  {
    price: 360000.0,
    property_type: :apartment,
    size: 180,
    bedrooms: 3,
    bathrooms: 2,
    sold: true,
    published_at: DateTime.new(2025, 1, 25)
  }
])
# Character.create(name: "Luke", movie: movies.first)
