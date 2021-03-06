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

ActiveRecord::Schema.define(version: 20140807203046) do

  create_table "apps", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "token"
  end

  create_table "apps_languages", id: false, force: :cascade do |t|
    t.integer "app_id"
    t.integer "language_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "iso"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "texts", force: :cascade do |t|
    t.text "literal"
    t.boolean "accepted", default: false, null: false
    t.integer "app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["app_id"], name: "index_texts_on_app_id"
  end

  create_table "translations", force: :cascade do |t|
    t.text "literal"
    t.integer "text_id"
    t.integer "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["language_id"], name: "index_translations_on_language_id"
    t.index ["text_id"], name: "index_translations_on_text_id"
  end

end
