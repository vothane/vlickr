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

ActiveRecord::Schema.define(version: 20130414231420) do

  create_table "albums", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "albums", ["user_id"], name: "index_albums_on_user_id"

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["video_id", "created_at"], name: "index_comments_on_video_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "user_name"
    t.string   "email"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.text     "player"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "videos", force: true do |t|
    t.string   "title"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "asset"
    t.integer  "album_id"
    t.integer  "user_id"
  end

  add_index "videos", ["album_id", "created_at"], name: "index_videos_on_album_id_and_created_at"
  add_index "videos", ["user_id"], name: "index_videos_on_user_id"

end
