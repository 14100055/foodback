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

ActiveRecord::Schema.define(version: 20160429080842) do

  create_table "foods", force: :cascade do |t|
    t.string   "restaurant"
    t.string   "name"
    t.integer  "price"
    t.time     "start_at"
    t.time     "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.integer  "budget",          default: 0
    t.text     "favourites",      default: ""
    t.text     "breakfast",       default: "You have no breakfast plan in place!"
    t.text     "lunch",           default: "You have no lunch plan in place!"
    t.text     "dinner",          default: "You have no dinner plan in place!"
    t.integer  "meals",           default: 0
    t.integer  "good_days",       default: 0
    t.integer  "bad_days",        default: 0
    t.integer  "original_budget", default: 0
    t.integer  "month_budget",    default: 0
    t.integer  "start_days",      default: -1
    t.integer  "middle_days",     default: 0
    t.integer  "end_days",        default: 0
    t.integer  "remaining_days",  default: 0
    t.text     "exotic",          default: "Its not the last day yet. :( "
  end

end
