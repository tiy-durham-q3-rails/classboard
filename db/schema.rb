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

ActiveRecord::Schema.define(version: 20140702155542) do

  create_table "allowed_accounts", force: true do |t|
    t.string   "github"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "allowed_accounts", ["github"], name: "index_allowed_accounts_on_github", unique: true

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id"

  create_table "help_requests", force: true do |t|
    t.text     "nature"
    t.text     "attempted"
    t.datetime "resolved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "repo"
  end

  add_index "help_requests", ["user_id"], name: "index_help_requests_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "teacher",    default: false, null: false
    t.string   "github"
  end

  add_index "users", ["github"], name: "index_users_on_github"

end
