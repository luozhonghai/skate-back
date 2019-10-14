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

ActiveRecord::Schema.define(version: 2019_10_14_080858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "device_id"
    t.string "nickname"
    t.integer "level"
    t.integer "score_single"
    t.decimal "score_0_online", precision: 9, scale: 3, default: "0.0"
    t.decimal "score_1_online", precision: 9, scale: 3, default: "0.0"
    t.decimal "score_2_online", precision: 9, scale: 3, default: "0.0"
    t.integer "try_challenge"
    t.integer "win_challenge"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "challenge_request"
    t.text "challenge_result"
  end

end
