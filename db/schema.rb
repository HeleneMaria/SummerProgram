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

ActiveRecord::Schema.define(version: 20160111234207) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.integer  "reader_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "books", ["reader_id", "created_at"], name: "index_books_on_reader_id_and_created_at"

  create_table "prizes", force: :cascade do |t|
    t.integer  "level"
    t.integer  "reader_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "prizes", ["reader_id"], name: "index_prizes_on_reader_id"

  create_table "readers", force: :cascade do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "phoneNumber"
    t.string   "email"
    t.string   "schoolFallName"
    t.string   "schoolFallGrade"
    t.string   "program"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "age"
    t.string   "tShirtSize"
    t.string   "newSchoolFallName"
    t.string   "notes"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
