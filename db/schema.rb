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

ActiveRecord::Schema.define(version: 20150630185016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string   "employee_number"
    t.date     "date_of_joining"
    t.string   "full_name"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "religion"
    t.string   "qualification"
    t.integer  "employee_category_id"
    t.integer  "employee_department_id"
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
    t.integer  "employee_position_id"
    t.string   "status"
    t.date     "pay_date"
    t.date     "next_due_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
