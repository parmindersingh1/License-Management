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

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20130722110821) do

=======
ActiveRecord::Schema.define(:version => 20130722103807) do

  create_table "keys", :force => true do |t|
    t.string   "generated_key"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

>>>>>>> a776f41715ccd2ea6339e243ef3869e4b6102999
  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end