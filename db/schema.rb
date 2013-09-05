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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130905081428) do

  create_table "product_licenses", :force => true do |t|
    t.string   "license_key"
    t.string   "calculated_key"
    t.string   "email"
    t.string   "machine_id"
    t.date     "expiry_date"
    t.integer  "reset_counter",      :default => 0
    t.boolean  "allow_regeneration", :default => false
    t.boolean  "is_assigned",        :default => false
    t.boolean  "is_created",         :default => false
    t.boolean  "is_deleted",         :default => false
    t.string   "created_by"
    t.string   "updated_by"
    t.date     "updated_date"
    t.integer  "product_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "product_licenses_products", :force => true do |t|
    t.integer "product_id"
    t.integer "product_license_id"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "version"
    t.date     "release_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
