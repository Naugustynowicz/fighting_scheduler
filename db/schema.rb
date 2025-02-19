# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_26_160453) do
  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
  end

  create_table "circuits", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "status_id"
    t.index ["status_id"], name: "index_circuits_on_status_id"
    t.index ["user_id"], name: "index_circuits_on_user_id"
  end

  create_table "circuits_statuses", id: false, force: :cascade do |t|
    t.integer "status_id", null: false
    t.integer "circuit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clubs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status_id"
    t.integer "user_id"
    t.integer "sport_id"
    t.integer "location_id"
    t.index ["location_id"], name: "index_clubs_on_location_id"
    t.index ["sport_id"], name: "index_clubs_on_sport_id"
    t.index ["status_id"], name: "index_clubs_on_status_id"
    t.index ["user_id"], name: "index_clubs_on_user_id"
  end

  create_table "clubs_statuses", id: false, force: :cascade do |t|
    t.integer "status_id", null: false
    t.integer "club_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.integer "article_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "evenements", force: :cascade do |t|
    t.string "type_event"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "attendees_nb"
    t.decimal "venue_fee"
    t.string "status"
    t.string "name"
    t.text "description"
    t.text "rules"
    t.text "schedule"
    t.text "brackets"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "locations_id", null: false
    t.integer "sports_id", null: false
    t.index ["locations_id"], name: "index_evenements_on_locations_id"
    t.index ["sports_id"], name: "index_evenements_on_sports_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "attendees_nb"
    t.decimal "venue_fee"
    t.integer "required_score"
    t.string "name"
    t.text "description"
    t.text "rules"
    t.text "schedule"
    t.text "brackets"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "status_id"
    t.integer "location_id"
    t.integer "sport_id"
    t.integer "type_event_id"
    t.index ["location_id"], name: "index_events_on_location_id"
    t.index ["sport_id"], name: "index_events_on_sport_id"
    t.index ["status_id"], name: "index_events_on_status_id"
    t.index ["type_event_id"], name: "index_events_on_type_event_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "events_statuses", id: false, force: :cascade do |t|
    t.integer "status_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "other"
    t.string "street"
    t.string "city"
    t.string "postal_code"
    t.string "country"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "club_id"
    t.index ["club_id"], name: "index_teams_on_club_id"
  end

  create_table "teams_events_circuits", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "event_id"
    t.integer "circuit_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circuit_id"], name: "index_teams_events_circuits_on_circuit_id"
    t.index ["event_id"], name: "index_teams_events_circuits_on_event_id"
    t.index ["team_id"], name: "index_teams_events_circuits_on_team_id"
  end

  create_table "type_events", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "other"
    t.string "position"
    t.boolean "first_team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "club_id"
    t.integer "team_id"
    t.integer "location_id"
    t.index ["club_id"], name: "index_users_on_club_id"
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  create_table "users_events_circuits", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.integer "circuit_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circuit_id"], name: "index_users_events_circuits_on_circuit_id"
    t.index ["event_id"], name: "index_users_events_circuits_on_event_id"
    t.index ["user_id"], name: "index_users_events_circuits_on_user_id"
  end

  add_foreign_key "circuits", "statuses"
  add_foreign_key "circuits", "users"
  add_foreign_key "clubs", "locations"
  add_foreign_key "clubs", "sports"
  add_foreign_key "clubs", "statuses"
  add_foreign_key "clubs", "users"
  add_foreign_key "comments", "articles"
  add_foreign_key "evenements", "locations", column: "locations_id"
  add_foreign_key "evenements", "sports", column: "sports_id"
  add_foreign_key "events", "locations"
  add_foreign_key "events", "sports"
  add_foreign_key "events", "statuses"
  add_foreign_key "events", "type_events"
  add_foreign_key "events", "users"
  add_foreign_key "teams", "clubs"
  add_foreign_key "users", "clubs"
  add_foreign_key "users", "locations"
  add_foreign_key "users", "teams"
end
