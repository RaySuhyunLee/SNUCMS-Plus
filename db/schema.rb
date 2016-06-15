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

ActiveRecord::Schema.define(version: 20160614164440) do

  create_table "comments", force: :cascade do |t|
    t.text     "contents"
    t.string   "commenter"
    t.integer  "issue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["issue_id"], name: "index_comments_on_issue_id"

  create_table "courses", force: :cascade do |t|
    t.string   "course_num"
    t.string   "title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "issue_num"
    t.text     "description"
    t.integer  "professor_id"
  end

  add_index "courses", ["professor_id"], name: "index_courses_on_professor_id"

  create_table "courses_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  add_index "courses_users", ["course_id"], name: "index_courses_users_on_course_id"
  add_index "courses_users", ["user_id"], name: "index_courses_users_on_user_id"

  create_table "crawl_logs", force: :cascade do |t|
    t.string   "url"
    t.text     "contents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "have_issue_id"
    t.string   "have_issue_type"
    t.integer  "parent_issue_id"
    t.datetime "due"
  end

  create_table "issues_issuetags", force: :cascade do |t|
    t.integer "issuetag_id"
    t.integer "issue_id"
  end

  add_index "issues_issuetags", ["issue_id"], name: "index_issues_issuetags_on_issue_id"
  add_index "issues_issuetags", ["issuetag_id"], name: "index_issues_issuetags_on_issuetag_id"

  create_table "issues_users", force: :cascade do |t|
    t.integer "issue_id"
    t.integer "user_id"
  end

  add_index "issues_users", ["issue_id"], name: "index_issues_users_on_issue_id"
  add_index "issues_users", ["user_id"], name: "index_issues_users_on_user_id"

  create_table "issuetags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professors", force: :cascade do |t|
    t.string   "name"
    t.text     "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "student_id"
    t.string   "college"
    t.string   "major"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",                     null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 1073741823
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

  create_table "wiki_pages", force: :cascade do |t|
    t.string   "title"
    t.text     "contents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
