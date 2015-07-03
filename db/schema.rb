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

ActiveRecord::Schema.define(version: 20150703181839) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"


  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "prefix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false

  create_table "documents", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "description"
    t.string   "attachment"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false

  end

  create_table "employees", force: :cascade do |t|
    t.string   "employee_number"
    t.date     "date_of_joining"
    t.string   "full_name"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "religion"
    t.string   "qualification"
    t.integer  "category_id"
    t.integer  "department_id"
    t.string   "marital_status"
    t.integer  "child_count"
    t.string   "father_name"
    t.string   "mother_name"
    t.string   "spouse_name"
    t.string   "blood_group"
    t.string   "nationality"
    t.string   "id_card_no"
    t.date     "id_card_expiry"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "country"
    t.string   "home_phone"
    t.string   "mobile_number"
    t.string   "email"
    t.float    "salary"
    t.integer  "position_id"
    t.string   "status"
    t.date     "pay_date"
    t.date     "next_due_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "positions", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "parents", force: :cascade do |t|
    t.string   "name"
    t.string   "relation"
    t.string   "education"
    t.string   "profession"
    t.string   "dob"
    t.string   "income"
    t.string   "iqamaNumber"
    t.string   "iqamaExpiry"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "country"
    t.string   "officePhone"
    t.string   "mobile"
    t.string   "email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "students", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "grade_id"
    t.string   "gender"
    t.string   "dob"
    t.string   "blood"
    t.string   "birth_place"
    t.string   "nationality"
    t.string   "language"
    t.string   "religion"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "pincode"
    t.string   "country"
    t.string   "mobile"
    t.string   "phone"
    t.string   "email"
    t.string   "parent_id"
    t.integer  "fee"
    t.string   "term"
    t.string   "dueDate"
    t.string   "image"
    t.string   "iqamaNumber"
    t.string   "iqamaExpiry"
    t.string   "previousInstitute"
    t.string   "year"
    t.string   "totalMarks"
    t.string   "obtainedMarks"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
