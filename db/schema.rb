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

ActiveRecord::Schema.define(version: 2020_03_01_213023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.bigint "series_id", null: false
    t.integer "event_index", null: false
    t.bigint "table_id", null: false
    t.integer "value", null: false
    t.boolean "bock", default: false, null: false
    t.boolean "counts_towards_total", default: true, null: false
    t.boolean "needs_repeat", default: false, null: false
    t.string "game_type", null: false
    t.bigint "regular_game_id"
    t.bigint "ramsch_game_id"
    t.integer "seat_1_player_index", null: false
    t.integer "seat_2_player_index", null: false
    t.integer "seat_3_player_index", null: false
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ramsch_game_id"], name: "index_games_on_ramsch_game_id"
    t.index ["regular_game_id"], name: "index_games_on_regular_game_id"
    t.index ["series_id", "event_index"], name: "index_games_on_series_id_and_event_index", unique: true
    t.index ["series_id"], name: "index_games_on_series_id"
    t.index ["table_id"], name: "index_games_on_table_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_players_on_name", unique: true
  end

  create_table "ramsch_games", force: :cascade do |t|
    t.boolean "first_seat_passed_on", default: false, null: false
    t.boolean "second_seat_passed_on", default: false, null: false
    t.boolean "third_seat_passed_on", default: false, null: false
    t.integer "point_receiver_seat", null: false
    t.bigint "regular_ramsch_game_id"
    t.index ["regular_ramsch_game_id"], name: "index_ramsch_games_on_regular_ramsch_game_id"
  end

  create_table "regular_games", force: :cascade do |t|
    t.integer "declarer_seat", null: false
    t.integer "counters", default: 0, null: false
    t.boolean "hand", default: false, null: false
    t.boolean "ouvert", default: false, null: false
    t.integer "game_value", null: false
    t.boolean "won", null: false
    t.bigint "suit_or_grand_game_id"
    t.index ["suit_or_grand_game_id"], name: "index_regular_games_on_suit_or_grand_game_id"
  end

  create_table "regular_ramsch_games", force: :cascade do |t|
    t.integer "jungfrau_seat"
    t.integer "point_receiver_two_seat"
    t.integer "point_receiver_three_seat"
    t.integer "receiver_of_last_trick_seat"
    t.integer "points_achieved", null: false
  end

  create_table "series", force: :cascade do |t|
    t.integer "table_size", default: 3, null: false
    t.boolean "closed", default: false, null: false
    t.boolean "counts_ramsch", default: false, null: false
    t.boolean "negative_notation", default: false, null: false
    t.date "date", null: false
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suit_or_grand_games", force: :cascade do |t|
    t.integer "base_value", null: false
    t.integer "straight_trumps", null: false
    t.boolean "with_old_one", null: false
    t.integer "declared_point_levels", default: 0, null: false
    t.integer "additional_point_levels", null: false
    t.boolean "spaltarsch", default: false, null: false
    t.integer "bidding_value"
  end

  create_table "table_changes", force: :cascade do |t|
    t.integer "series_id", null: false
    t.integer "table_id", null: false
    t.integer "event_index", null: false
    t.index ["series_id", "event_index"], name: "index_table_changes_on_series_id_and_event_index", unique: true
    t.index ["series_id"], name: "index_table_changes_on_series_id"
    t.index ["table_id"], name: "index_table_changes_on_table_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "size"
    t.integer "player_1_id"
    t.integer "player_2_id"
    t.integer "player_3_id"
    t.integer "player_4_id"
    t.integer "player_5_id"
    t.index ["player_1_id"], name: "index_tables_on_player_1_id"
    t.index ["player_2_id"], name: "index_tables_on_player_2_id"
    t.index ["player_3_id"], name: "index_tables_on_player_3_id"
    t.index ["player_4_id"], name: "index_tables_on_player_4_id"
    t.index ["player_5_id"], name: "index_tables_on_player_5_id"
    t.index ["size", "player_1_id", "player_2_id", "player_3_id", "player_4_id", "player_5_id"], name: "unique_tables", unique: true
  end

  add_foreign_key "games", "ramsch_games"
  add_foreign_key "games", "regular_games"
  add_foreign_key "games", "series"
  add_foreign_key "games", "tables"
  add_foreign_key "ramsch_games", "regular_ramsch_games"
  add_foreign_key "regular_games", "suit_or_grand_games"
end
