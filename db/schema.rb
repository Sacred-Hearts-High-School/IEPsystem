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

ActiveRecord::Schema.define(version: 20140916021311) do

  create_table "attachments", force: true do |t|
    t.integer  "classroom_id"
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "post_id"
    t.string   "title"
    t.text     "content"
    t.string   "filename"
    t.integer  "type"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remark"
  end

  create_table "classrooms", force: true do |t|
    t.integer  "semester_id"
    t.integer  "num"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "taxonomies"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "s_in_cs", force: true do |t|
    t.integer  "classroom_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "semesters", force: true do |t|
    t.integer  "year"
    t.integer  "semester"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "no"
    t.string   "pid"
    t.string   "email"
    t.integer  "stu_type"
    t.string   "stu_class"
    t.text     "disable_desc"
    t.string   "father"
    t.string   "father_phone"
    t.string   "mother"
    t.string   "mother_phone"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t_in_cs", force: true do |t|
    t.integer  "classroom_id"
    t.integer  "teacher_id"
    t.string   "subject"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxonomies", force: true do |t|
    t.string   "name"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.string   "email"
    t.string   "subject1"
    t.string   "subject2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "role_id"
    t.integer  "my_role_id"
    t.integer  "enable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",         default: false
  end

end
