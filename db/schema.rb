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

ActiveRecord::Schema.define(version: 20150722150142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bridges", force: :cascade do |t|
    t.integer  "subject_id"
    t.integer  "grade_id"
    t.integer  "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

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
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "description"
    t.string   "attachment"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "emergencies", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "student_id"
  end

  create_table "employee_attendances", force: :cascade do |t|
    t.integer  "employee_id"
    t.date     "attendance_date"
    t.boolean  "epresent",        default: true
    t.boolean  "eleave",          default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
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
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "total_experience_years"
    t.integer  "total_experience_months"
  end

  create_table "fees", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "amount"
    t.integer  "user_id"
    t.string   "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grades", force: :cascade do |t|
    t.string   "name"
    t.string   "section"
    t.integer  "batch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaves", force: :cascade do |t|
    t.string   "reason"
    t.text     "description"
    t.integer  "employee_id"
    t.date     "leave_from"
    t.date     "leave_to"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "approved",    default: false
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

  create_table "positions", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "name"
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
    t.string   "image"
    t.string   "iqamaNumber"
    t.string   "iqamaExpiry"
    t.string   "previousInstitute"
    t.string   "year"
    t.string   "totalMarks"
    t.string   "obtainedMarks"
    t.string   "forthname"
    t.string   "fifthname"
    t.string   "arabicname"
    t.string   "weight"
    t.string   "height"
    t.string   "eyeside"
    t.string   "hearing"
    t.string   "rh"
    t.string   "alergy"
    t.string   "nurology"
    t.string   "physical"
    t.string   "disability"
    t.string   "behaviour"
    t.string   "fullname"
    t.string   "due_date"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
