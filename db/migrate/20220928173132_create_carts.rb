class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.float :gross_amount
      t.timestamps
    end
  end
end
