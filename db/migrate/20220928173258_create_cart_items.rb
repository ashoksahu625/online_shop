class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.integer :cart_id
      t.integer :quantity
      t.float :total_price
      t.float :base_price
      t.string :name
      t.string :item_attribute
      t.text :description
      t.float :item_price
      t.boolean :is_out_of_stock, defualt: false
      t.boolean :is_item_available, defualt: true
      t.string :pos_category_id
      t.string :pos_item_id
      t.string :pos_category_name
      t.string :sub_category_name
      t.integer :variation_id
      t.string :item_type
      t.integer :parent_item_id
      t.float :display_price
      t.integer :addon_id
      t.integer :user_id
      t.string :addon_group_id
      t.string :addon_group_name
      t.timestamps
    end
  end
end
