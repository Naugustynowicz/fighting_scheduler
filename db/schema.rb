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

ActiveRecord::Schema[8.0].define(version: 2025_03_24_100743) do
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
    t.index ["circuit_id"], name: "index_circuits_statuses_on_circuit_id"
    t.index ["status_id"], name: "index_circuits_statuses_on_status_id"
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
    t.index ["club_id"], name: "index_clubs_statuses_on_club_id"
    t.index ["status_id"], name: "index_clubs_statuses_on_status_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bracket_id"
    t.integer "user_id"
    t.integer "circuit_id"
    t.integer "club_id"
    t.integer "status_id"
    t.integer "location_id"
    t.integer "sport_id"
    t.integer "type_event_id"
    t.index ["bracket_id"], name: "index_events_on_bracket_id"
    t.index ["circuit_id"], name: "index_events_on_circuit_id"
    t.index ["club_id"], name: "index_events_on_club_id"
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
    t.index ["event_id"], name: "index_events_statuses_on_event_id"
    t.index ["status_id"], name: "index_events_statuses_on_status_id"
  end

  create_table "events_teams", id: false, force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "event_id", null: false
    t.integer "circuit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circuit_id"], name: "index_events_teams_on_circuit_id"
    t.index ["event_id"], name: "index_events_teams_on_event_id"
    t.index ["team_id"], name: "index_events_teams_on_team_id"
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.integer "circuit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circuit_id"], name: "index_events_users_on_circuit_id"
    t.index ["event_id"], name: "index_events_users_on_event_id"
    t.index ["user_id"], name: "index_events_users_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "other"
    t.string "street"
    t.string "city"
    t.string "postal_code"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user1_id"
    t.integer "user2_id"
    t.integer "winner_id"
    t.bigint "previous_match_1"
    t.bigint "previous_match_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_matches_on_event_id"
    t.index ["user1_id"], name: "index_matches_on_user1_id"
    t.index ["user2_id"], name: "index_matches_on_user2_id"
    t.index ["winner_id"], name: "index_matches_on_winner_id"
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
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.text "description"
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

  create_table "type_events", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "other"
    t.string "position"
    t.boolean "first_team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "club_id"
    t.integer "team_id"
    t.integer "location_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "jti"
    t.index ["club_id"], name: "index_users_on_club_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "circuits", "statuses", on_delete: :nullify
  add_foreign_key "circuits", "users", on_delete: :nullify
  add_foreign_key "clubs", "locations", on_delete: :nullify
  add_foreign_key "clubs", "sports", on_delete: :nullify
  add_foreign_key "clubs", "statuses", on_delete: :nullify
  add_foreign_key "clubs", "users", on_delete: :nullify
  add_foreign_key "events", "circuits", on_delete: :nullify
  add_foreign_key "events", "clubs", on_delete: :nullify
  add_foreign_key "events", "locations", on_delete: :nullify
  add_foreign_key "events", "matches", column: "bracket_id", on_delete: :cascade
  add_foreign_key "events", "sports", on_delete: :nullify
  add_foreign_key "events", "statuses", on_delete: :nullify
  add_foreign_key "events", "type_events", on_delete: :nullify
  add_foreign_key "events", "users", on_delete: :nullify
  add_foreign_key "events_teams", "circuits", on_delete: :nullify
  add_foreign_key "events_users", "circuits", on_delete: :nullify
  add_foreign_key "matches", "events", on_delete: :cascade
  add_foreign_key "matches", "users", column: "user1_id", on_delete: :cascade
  add_foreign_key "matches", "users", column: "user2_id", on_delete: :cascade
  add_foreign_key "matches", "users", column: "winner_id", on_delete: :cascade
  add_foreign_key "teams", "clubs", on_delete: :nullify
  add_foreign_key "users", "clubs", on_delete: :nullify
  add_foreign_key "users", "locations", on_delete: :nullify
  add_foreign_key "users", "teams", on_delete: :nullify
end
