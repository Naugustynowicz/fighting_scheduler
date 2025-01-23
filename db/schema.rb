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

ActiveRecord::Schema[7.2].define(version: 2024_11_17_130726) do
  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
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

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "articles"
  add_foreign_key "evenements", "locations", column: "locations_id"
  add_foreign_key "evenements", "sports", column: "sports_id"
end
