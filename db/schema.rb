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

ActiveRecord::Schema.define(version: 20210308142023) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "month_check_superior"
    t.string "month_checker"
    t.time "overtime"
    t.string "task_menu"
    t.boolean "next_day", default: false
    t.string "superior"
    t.string "status"
    t.boolean "superior_checker"
    t.datetime "restarted_at"
    t.datetime "refinished_at"
    t.string "month_status"
    t.string "month_nextday"
    t.boolean "change_checker"
    t.string "total_month_superior"
    t.string "total_month_status"
    t.boolean "total_month_checker"
    t.string "total_month"
    t.boolean "change_next_day", default: false
    t.date "month_update"
    t.date "log_year"
    t.date "log_month"
    t.datetime "before_change_started"
    t.datetime "before_change_finished"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "place_num"
    t.string "place_name"
    t.string "place_status"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.datetime "basic_work_time", default: "2021-03-19 23:00:00"
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
