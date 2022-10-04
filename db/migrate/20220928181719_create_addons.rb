class CreateAddons < ActiveRecord::Migration[7.0]
  def change
    create_table :addons do |t|
      t.string :name
      t.string :addon_type
      t.integer :min
      t.integer :max
      t.integer :cart_item_id
      t.text :description
      t.timestamps
    end
  end
end
