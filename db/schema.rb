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

ActiveRecord::Schema.define(version: 20140215173958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.datetime "target_date"
    t.datetime "completed_date"
    t.string   "type"
    t.string   "status",          default: "pending"
    t.text     "notes"
    t.integer  "address_id"
    t.integer  "contact_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "installation_id"
  end

  add_index "activities", ["installation_id"], name: "index_activities_on_installation_id", using: :btree

  create_table "addresses", force: true do |t|
    t.string   "city"
    t.string   "state"
    t.string   "street"
    t.integer  "number"
    t.string   "apartment"
    t.string   "zip_code"
    t.string   "notes"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["contact_id"], name: "index_addresses_on_contact_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.date     "birthday"
    t.text     "notes"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id"
    t.date     "source_date"
  end

  add_index "contacts", ["source_id"], name: "index_contacts_on_source_id", using: :btree
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "installations", force: true do |t|
    t.date     "date"
    t.integer  "kit_id"
    t.integer  "contact_id"
    t.integer  "address_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "installations", ["address_id"], name: "index_installations_on_address_id", using: :btree
  add_index "installations", ["contact_id"], name: "index_installations_on_contact_id", using: :btree
  add_index "installations", ["kit_id"], name: "index_installations_on_kit_id", using: :btree
  add_index "installations", ["user_id"], name: "index_installations_on_user_id", using: :btree

  create_table "kits", force: true do |t|
    t.string   "serial_number"
    t.date     "acquisition_date"
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kits", ["product_id"], name: "index_kits_on_product_id", using: :btree
  add_index "kits", ["user_id"], name: "index_kits_on_user_id", using: :btree

  create_table "phone_numbers", force: true do |t|
    t.string   "number"
    t.string   "kind"
    t.integer  "address_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phone_numbers", ["address_id"], name: "index_phone_numbers_on_address_id", using: :btree
  add_index "phone_numbers", ["contact_id"], name: "index_phone_numbers_on_contact_id", using: :btree

  create_table "products", force: true do |t|
    t.float    "bonificable_points"
    t.string   "name"
    t.integer  "list_price_cents",         default: 0,     null: false
    t.string   "list_price_currency",      default: "ARS", null: false
    t.integer  "suggested_price_cents",    default: 0,     null: false
    t.string   "suggested_price_currency", default: "ARS", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "expiration_time"
    t.integer  "service_period"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
