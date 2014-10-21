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

ActiveRecord::Schema.define(version: 20141021064135) do

  create_table "corrections", force: true do |t|
    t.integer  "sentence_id"
    t.string   "advice"
    t.integer  "advisor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "corrections", ["advisor_id"], name: "index_corrections_on_advisor_id"
  add_index "corrections", ["sentence_id"], name: "index_corrections_on_sentence_id"

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: true do |t|
    t.string   "title"
    t.integer  "author_id"
    t.string   "language"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reports", ["author_id"], name: "index_reports_on_author_id"

  create_table "sentences", force: true do |t|
    t.integer  "report_id"
    t.string   "line"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sentences", ["report_id"], name: "index_sentences_on_report_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "interface_language"
    t.text     "introduction"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["department_id"], name: "index_users_on_department_id"

end
