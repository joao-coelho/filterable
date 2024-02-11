class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.float :price 	      , null: false
      t.integer :property_type, null: false

      t.timestamps
    end
  end
end
