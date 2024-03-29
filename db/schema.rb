# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_18_121348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts", force: :cascade do |t|
    t.string "client_name"
    t.date "start_date"
    t.date "end_date"
    t.time "monday_start_hour"
    t.time "monday_end_hour"
    t.time "tuesday_start_hour"
    t.time "tuesday_end_hour"
    t.time "wednesday_start_hour"
    t.time "wednesday_end_hour"
    t.time "thursday_start_hour"
    t.time "thursday_end_hour"
    t.time "friday_start_hour"
    t.time "friday_end_hour"
    t.time "saturday_start_hour"
    t.time "saturday_end_hour"
    t.time "sunday_start_hour"
    t.time "sunday_end_hour"
    t.float "price_per_hour"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "monitoring_shifts", force: :cascade do |t|
    t.time "start_hour"
    t.time "end_hour"
    t.integer "duration"
    t.bigint "user_id"
    t.date "date"
    t.integer "week_number"
    t.bigint "contract_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contract_id"], name: "index_monitoring_shifts_on_contract_id"
    t.index ["user_id"], name: "index_monitoring_shifts_on_user_id"
  end

  create_table "user_monitoring_shifts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "monitoring_shift_id", null: false
    t.boolean "available", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["monitoring_shift_id"], name: "index_user_monitoring_shifts_on_monitoring_shift_id"
    t.index ["user_id"], name: "index_user_monitoring_shifts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.boolean "admin", default: false
    t.boolean "dev", default: false
    t.string "authentication_token", limit: 30
    t.string "colour"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "monitoring_shifts", "contracts"
  add_foreign_key "monitoring_shifts", "users"
  add_foreign_key "user_monitoring_shifts", "monitoring_shifts"
  add_foreign_key "user_monitoring_shifts", "users"
end
