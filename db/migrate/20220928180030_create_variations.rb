class CreateVariations < ActiveRecord::Migration[7.0]
  def change
    create_table :variations do |t|
      t.string :name
      t.text :description
      t.string :variation_type
      t.integer :cart_item_id
      t.boolean :has_addons, defualt: false
      t.timestamps
    end
  end
end
