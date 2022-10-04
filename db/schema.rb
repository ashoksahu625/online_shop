# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_28_181719) do
  create_table "addons", force: :cascade do |t|
    t.string "name"
    t.string "addon_type"
    t.integer "min"
    t.integer "max"
    t.integer "cart_item_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "quantity"
    t.float "total_price"
    t.float "base_price"
    t.string "name"
    t.string "item_attribute"
    t.text "description"
    t.float "item_price"
    t.boolean "is_out_of_stock"
    t.boolean "is_item_available"
    t.string "pos_category_id"
    t.string "pos_item_id"
    t.string "pos_category_name"
    t.string "sub_category_name"
    t.integer "variation_id"
    t.string "item_type"
    t.integer "parent_item_id"
    t.float "display_price"
    t.integer "addon_id"
    t.integer "user_id"
    t.string "addon_group_id"
    t.string "addon_group_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.float "gross_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "mobile_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "variation_type"
    t.integer "cart_item_id"
    t.boolean "has_addons"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
