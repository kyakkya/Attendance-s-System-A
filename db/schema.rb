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

ActiveRecord::Schema.define(version: 20201219125539) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "month_check_superior"
    t.string "month_checker"
    t.time "overtime" #残業の申請時間
    t.string "task_menu" #残業時業務処理内容
    t.boolean "next_day", superior_checkerdefault: false
    t.string "superior" #残業申請用上長
    t.string "status"
    t.boolean ""
    t.time "restated_at"
    t.time "refinished_at"
    t.integer "user_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.datetime "basic_work_time", default: "2020-12-08 23:00:00"
    t.boolean "superior", default: false
    t.string "affiliation"
    t.string "uid"
    t.integer "employee_number"
    t.time "designated_work_start_time", default: "2000-01-01 00:00:00"
    t.time "designated_work_end_time", default: "2000-01-01 09:00:00"
    t.string "month_superior"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
