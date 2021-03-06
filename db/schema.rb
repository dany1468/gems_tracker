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

ActiveRecord::Schema.define(version: 20160819140538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "execution_histories", force: :cascade do |t|
    t.bigserial "latest_tweet_id", null: false
    t.bigserial "start_tweet_id",  null: false
  end

  create_table "ignoring_gems", force: :cascade do |t|
    t.string "name",               null: false
    t.string "registered_version", null: false
  end

  create_table "tracking_gems", force: :cascade do |t|
    t.string "name",           null: false
    t.string "latest_version", null: false
    t.string "source_url"
    t.index ["name"], name: "index_tracking_gems_on_name", unique: true, using: :btree
  end

  create_table "unread_gems", force: :cascade do |t|
    t.string "name",        null: false
    t.string "description"
    t.string "version",     null: false
    t.string "url",         null: false
  end

end
