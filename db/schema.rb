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

ActiveRecord::Schema.define(version: 20160323062334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "super_admin",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "levels", force: :cascade do |t|
    t.string   "name",           null: false
    t.integer  "games_required", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_players", force: :cascade do |t|
    t.integer  "player_id",              null: false
    t.integer  "match_id",               null: false
    t.integer  "score",      default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "matches", force: :cascade do |t|
    t.string   "table_number"
    t.string   "status",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
    t.string   "bracket_position"
  end

  add_index "matches", ["tournament_id"], name: "index_matches_on_tournament_id", using: :btree

  create_table "player_tournaments", force: :cascade do |t|
    t.integer  "tournament_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: :cascade do |t|
    t.string   "first_name",   null: false
    t.string   "last_name"
    t.string   "email"
    t.integer  "level_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.boolean  "enable_phone"
    t.boolean  "enable_email"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race"
    t.integer  "final_race"
    t.string   "bye_pattern"
    t.string   "bracket_type"
    t.text     "table_numbers"
    t.string   "mode"
  end

end
