# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160411215455) do

  create_table "tweets", force: :cascade do |t|
    t.string   "text"
    t.datetime "posted_at"
    t.integer  "retweets"
    t.integer  "likes"
    t.integer  "twitter_account_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "tweets", ["twitter_account_id"], name: "index_tweets_on_twitter_account_id"

  create_table "twitter_accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "screenname"
    t.string   "profile_picture_url"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

end
