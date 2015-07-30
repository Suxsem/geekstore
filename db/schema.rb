# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150730151739) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "status"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "orders_upgrades", id: false, force: :cascade do |t|
    t.integer "order_id"
    t.integer "upgrade_id"
  end

  add_index "orders_upgrades", ["order_id"], name: "index_orders_upgrades_on_order_id"
  add_index "orders_upgrades", ["upgrade_id"], name: "index_orders_upgrades_on_upgrade_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "image"
    t.decimal  "price"
    t.integer  "discount",    default: 0
    t.integer  "category_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"
  add_index "products", ["discount"], name: "index_products_on_discount"
  add_index "products", ["name"], name: "index_products_on_name", unique: true
  add_index "products", ["price"], name: "index_products_on_price"

  create_table "products_stores", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "store_id"
  end

  add_index "products_stores", ["product_id"], name: "index_products_stores_on_product_id"
  add_index "products_stores", ["store_id"], name: "index_products_stores_on_store_id"

  create_table "stores", force: :cascade do |t|
    t.string   "place"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stores", ["place"], name: "index_stores_on_place", unique: true

  create_table "upgrades", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "upgrades", ["name", "product_id"], name: "index_upgrades_on_name_and_product_id", unique: true
  add_index "upgrades", ["product_id"], name: "index_upgrades_on_product_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
    t.string   "password_digest"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true

end
