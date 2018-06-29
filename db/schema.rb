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

ActiveRecord::Schema.define(version: 2018_06_29_070605) do

  create_table "hackathons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "host_introduction"
    t.string "topic"
    t.string "address"
    t.integer "host_fund_wei"
    t.integer "target_fund_wei"
    t.integer "teams_count"
    t.integer "participation_fee_wei"
    t.binary "award_wei_list"
    t.integer "vote_reward_percent"
    t.datetime "crow_funding_start_at"
    t.datetime "apply_start_at"
    t.datetime "game_start_at"
    t.datetime "vote_start_at"
    t.datetime "finished_at"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "hackathon_id"
    t.integer "user_id"
    t.string "name"
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "introduction"
    t.string "address"
    t.string "password_digest"
    t.string "token"
    t.string "bind_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
