# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_20_212825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domains", force: :cascade do |t|
    t.string "url"
    t.string "alexa_rank"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["url"], name: "index_domains_on_url", unique: true
  end

  create_table "short_urls", force: :cascade do |t|
    t.bigint "domain_id", null: false
    t.string "url"
    t.string "short_code", limit: 5
    t.integer "visits"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["domain_id"], name: "index_short_urls_on_domain_id"
    t.index ["short_code"], name: "index_short_urls_on_short_code", unique: true
    t.index ["url"], name: "index_short_urls_on_url", unique: true
  end

  add_foreign_key "short_urls", "domains"
end
