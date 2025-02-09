class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.float :price, null: false
      t.integer :property_type, null: false
      t.integer :size, null: false
      t.integer :bedrooms, null: false
      t.integer :bathrooms, null: false
      t.boolean :sold, null: false, default: false
      t.datetime :published_at, null: false

      t.timestamps
    end
  end
end
