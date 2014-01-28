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

ActiveRecord::Schema.define(version: 20131126102308) do

  create_table "model0s", force: true do |t|
    t.string   "string_col"
    t.text     "text_col"
    t.integer  "integer_col"
    t.integer  "integer_col2"
    t.integer  "integer_col3"
    t.float    "float_col"
    t.datetime "timestamp_col"
    t.integer  "model1_id"
    t.string   "string_col2"
  end

  create_table "model1s", force: true do |t|
    t.string  "string_col"
    t.integer "integer_col"
    t.integer "not_in_model0"
    t.integer "model2_id"
    t.integer "model22_id"
  end

  create_table "model22s", force: true do |t|
    t.string  "string_col"
    t.integer "integer_col"
  end

  create_table "model2s", force: true do |t|
    t.string  "string_col"
    t.integer "integer_col"
    t.integer "model3_id"
  end

  create_table "model3s", force: true do |t|
    t.string  "string_col"
    t.integer "integer_col"
  end

  create_table "upload_totals", force: true do |t|
    t.integer "upload_total"
  end

  create_table "users", force: true do |t|
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
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
