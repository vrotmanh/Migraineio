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

ActiveRecord::Schema.define(version: 20171116214932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "algorithms", force: :cascade do |t|
    t.text "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "name"
    t.float "accuracy", default: 0.0
  end

  create_table "migraine_reports", force: :cascade do |t|
    t.integer "stress"
    t.integer "anxiety"
    t.float "sleep_time"
    t.boolean "chocolate"
    t.boolean "cheese"
    t.boolean "sinus"
    t.boolean "caffeine"
    t.boolean "skipped_meal"
    t.boolean "prediction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "algorithm_id"
    t.boolean "train_data"
    t.boolean "label"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "kind"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
