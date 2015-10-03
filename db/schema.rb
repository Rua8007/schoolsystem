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

ActiveRecord::Schema.define(version: 20151003071418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "add_result_to_marksheets", force: :cascade do |t|
    t.integer  "result_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.integer  "total_days"
  end

  create_table "bus_allotments", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "transport_id"
    t.integer  "route_id"
    t.integer  "stop_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "fee"
  end

  create_table "calenders", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "starttime"
    t.datetime "endtime"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "grade"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "prefix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "curriculum_details", force: :cascade do |t|
    t.text     "month"
    t.integer  "day"
    t.string   "sol"
    t.string   "strand"
    t.text     "content"
    t.text     "skill"
    t.text     "activity"
    t.text     "assessment"
    t.integer  "curriculum_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "curriculums", force: :cascade do |t|
    t.integer  "grade_id"
    t.integer  "subject_id"
    t.text     "studentname"
    t.integer  "year_plan_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "approved",     default: false
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

  create_table "examcalenders", force: :cascade do |t|
    t.integer  "bridge_id"
    t.string   "title"
    t.text     "description"
    t.string   "category"
    t.datetime "starttime"
    t.datetime "endtime"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "exams", force: :cascade do |t|
    t.string   "name"
    t.integer  "batch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "start_date"
    t.string   "end_date"
  end

  create_table "feebreakdowns", force: :cascade do |t|
    t.integer  "grade_id"
    t.string   "title"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fees", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "amount"
    t.integer  "user_id"
    t.string   "month"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "feebreakdown_id"
    t.string   "category"
    t.integer  "identifier"
  end

  create_table "grade_subjects", force: :cascade do |t|
    t.integer  "subject_id"
    t.integer  "grade_id"
    t.integer  "week_id"
    t.string   "dayname"
    t.text     "classwork"
    t.text     "homework"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "approved",     default: false
    t.string   "day_name_eng"
  end

  create_table "grades", force: :cascade do |t|
    t.string   "name"
    t.string   "section"
    t.integer  "batch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string   "booknum"
    t.integer  "student_id"
    t.float    "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "shopcategory_id"
    t.string   "size"
    t.float    "price"
    t.integer  "grade_id"
    t.integer  "sold"
    t.integer  "left"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "purchase"
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

  create_table "lessonplan_details", force: :cascade do |t|
    t.integer  "subject_id"
    t.integer  "lessonplan_id"
    t.string   "period"
    t.text     "procedure"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "lessonplans", force: :cascade do |t|
    t.integer  "grade_id"
    t.integer  "subject_id"
    t.string   "topic"
    t.string   "selection"
    t.string   "startdate"
    t.string   "enddate"
    t.text     "studentengage"
    t.text     "newvocabulary"
    t.text     "objectives"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "year_plan_id"
    t.boolean  "approved",      default: false
  end

  create_table "lines", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "invoice_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "package_id"
    t.float    "price"
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "marks", force: :cascade do |t|
    t.string   "name"
    t.float    "marks"
    t.float    "passing_marks"
    t.integer  "grade_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "marksheets", force: :cascade do |t|
    t.integer  "exam_id"
    t.integer  "bridge_id"
    t.integer  "totalmarks"
    t.float    "obtainedmarks"
    t.integer  "student_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "result_id"
  end

  create_table "packageitems", force: :cascade do |t|
    t.integer  "package_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.float    "price"
    t.integer  "sold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "grade_id"
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
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "mothername"
    t.string   "mothermobile"
    t.string   "motheremail"
  end

  create_table "performances", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "bridge_id"
    t.text     "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "periods", force: :cascade do |t|
    t.integer  "time_table_id"
    t.integer  "period_num"
    t.integer  "subject_id"
    t.string   "day"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "portion_details", force: :cascade do |t|
    t.integer  "portion_id"
    t.integer  "subject_id"
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "details"
  end

  create_table "portions", force: :cascade do |t|
    t.integer  "year_plan_id"
    t.string   "quarter"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "approved",     default: false
    t.integer  "grade_id"
  end

  create_table "positions", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "purchaselines", force: :cascade do |t|
    t.integer  "purchase_id"
    t.string   "code"
    t.integer  "quantity"
    t.float    "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "grade_id"
    t.integer  "employee_id"
    t.text     "detail"
    t.boolean  "approve"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "results", force: :cascade do |t|
    t.integer  "exam_id"
    t.integer  "bridge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rights", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessionals", force: :cascade do |t|
    t.integer  "marksheet_id"
    t.integer  "mark_id"
    t.float    "marks"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "shopcategories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stops", force: :cascade do |t|
    t.string   "name"
    t.integer  "route_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_attendances", force: :cascade do |t|
    t.integer  "student_id"
    t.date     "attendance_date"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "epresent",        default: true
    t.boolean  "eleave",          default: false
    t.boolean  "late",            default: false
  end

  create_table "student_holidays", force: :cascade do |t|
    t.string   "reason"
    t.text     "description"
    t.integer  "student_id"
    t.date     "leave_from"
    t.date     "leave_to"
    t.boolean  "approved",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
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
    t.float    "discount"
    t.string   "specialneed"
    t.string   "rollnumber"
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_tables", force: :cascade do |t|
    t.integer  "grade_id"
    t.integer  "employee_id"
    t.integer  "break_after_period"
    t.integer  "prayer_after_period"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "transportfeerecords", force: :cascade do |t|
    t.integer  "bus_allotment_id"
    t.float    "fee"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "status"
    t.integer  "identifier"
  end

  create_table "transports", force: :cascade do |t|
    t.string   "arrival"
    t.string   "departure"
    t.integer  "employee_id"
    t.integer  "route_id"
    t.integer  "vehicle_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "no"
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
    t.integer  "role_id"
    t.boolean  "is_active"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.string   "code"
    t.string   "seat"
    t.string   "max_allowed"
    t.string   "vehicle_type"
    t.string   "insurance"
    t.string   "tax"
    t.string   "permit"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "vehicle_no"
  end

  create_table "weekends", force: :cascade do |t|
    t.integer  "weekend_day"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "weeks", force: :cascade do |t|
    t.integer  "year_plan_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "holiday_description"
    t.integer  "year_week_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "year_plans", force: :cascade do |t|
    t.string   "year_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
end
