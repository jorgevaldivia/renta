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

ActiveRecord::Schema.define(version: 20150503173725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "bank_accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "holder_name"
    t.string   "clabe"
    t.hstore   "open_pay_data", default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bank_accounts", ["user_id"], name: "index_bank_accounts_on_user_id", using: :btree

  create_table "invoice_line_items", force: true do |t|
    t.integer  "invoice_id"
    t.string   "summary"
    t.integer  "amount_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoice_line_items", ["invoice_id"], name: "index_invoice_line_items_on_invoice_id", using: :btree

  create_table "invoices", force: true do |t|
    t.integer  "user_id"
    t.integer  "lease_id"
    t.string   "subject"
    t.date     "issue_date"
    t.date     "due_date"
    t.string   "status"
    t.integer  "total_amount_cents"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["lease_id"], name: "index_invoices_on_lease_id", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "leases", force: true do |t|
    t.integer  "property_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "frequency"
    t.integer  "interval"
    t.integer  "deposit_cents"
    t.integer  "rent_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "next_bill_date"
    t.integer  "grace_period"
    t.integer  "user_id"
  end

  add_index "leases", ["property_id"], name: "index_leases_on_property_id", using: :btree
  add_index "leases", ["user_id"], name: "index_leases_on_user_id", using: :btree

  create_table "properties", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_revenue_cents"
    t.integer  "total_expenses_cents"
    t.integer  "total_profit_cents"
    t.integer  "current_lease_id"
    t.float    "beds"
    t.float    "baths"
    t.integer  "size"
    t.string   "size_unit"
  end

  add_index "properties", ["current_lease_id"], name: "index_properties_on_current_lease_id", using: :btree
  add_index "properties", ["user_id"], name: "index_properties_on_user_id", using: :btree

  create_table "transactions", force: true do |t|
    t.integer  "user_id"
    t.string   "item_type"
    t.integer  "item_id"
    t.integer  "amount_cents"
    t.string   "transaction_type"
    t.string   "summary"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["item_id"], name: "index_transactions_on_item_id", using: :btree
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "open_pay_data",          default: {}
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
