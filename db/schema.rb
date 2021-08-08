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

ActiveRecord::Schema.define(version: 2021_08_06_101303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.string "name_spoken"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spot_reviews", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "posted_at"
    t.string "comment"
    t.integer "view_count"
    t.bigint "spot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spot_id"], name: "index_spot_reviews_on_spot_id"
  end

  create_table "spot_schedules", force: :cascade do |t|
    t.integer "kind"
    t.integer "season"
    t.datetime "start_on"
    t.datetime "end_on"
    t.string "day_of_week"
    t.string "hour"
    t.string "note"
    t.bigint "spot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spot_id"], name: "index_spot_schedules_on_spot_id"
  end

  create_table "spot_tags", force: :cascade do |t|
    t.integer "spot_id"
    t.integer "tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spots", force: :cascade do |t|
    t.string "name"
    t.string "sub_name"
    t.string "body"
    t.string "address"
    t.string "building"
    t.string "phone"
    t.string "restroom_qty"
    t.string "wifi"
    t.string "base_id"
    t.bigint "prefecture_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "spot_reviews_count"
    t.index ["prefecture_id"], name: "index_spots_on_prefecture_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "nickname"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
  end

  add_foreign_key "spot_reviews", "spots"
  add_foreign_key "spot_schedules", "spots"
  add_foreign_key "spots", "prefectures"
end
