ActiveRecord::Schema.define(version: 20180118104720) do

  create_table "invoices", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.decimal  "amount",                 precision: 10
    t.integer  "order_id",   limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "invoices", ["order_id"], name: "fk_rails_4fa42a6dca", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "menu_type",     limit: 255
    t.string   "name",          limit: 255
    t.decimal  "price",                     precision: 10
    t.integer  "restaurant_id", limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "menus", ["restaurant_id"], name: "fk_rails_4d07a806b1", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "code",                       limit: 255
    t.text     "food_details_with_quantity", limit: 65535
    t.integer  "menu_id",                    limit: 4
    t.integer  "user_id",                    limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "orders", ["menu_id"], name: "fk_rails_1bee5e9459", using: :btree
  add_index "orders", ["user_id"], name: "fk_rails_f868b47f6a", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address",    limit: 255
    t.string   "city",       limit: 255
    t.string   "phone_no",   limit: 255
    t.decimal  "rating",                 precision: 10
    t.boolean  "is_veg",                                default: true
    t.boolean  "has_bar",                               default: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "address",       limit: 255
    t.string   "phone_no",      limit: 255
    t.integer  "restaurant_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "users", ["restaurant_id"], name: "fk_rails_72692f1976", using: :btree

  add_foreign_key "invoices", "orders"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "orders", "menus"
  add_foreign_key "orders", "users"
  add_foreign_key "users", "restaurants"
end
