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

ActiveRecord::Schema.define(version: 20170516155904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer "round_id"
    t.integer "hand_id"
    t.string "suit"
    t.integer "value"
  end

  create_table "hands", force: :cascade do |t|
    t.integer "player_id"
    t.integer "bet"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "money"
    t.integer "round_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "pot"
    t.integer "active_player_id"
  end

end
