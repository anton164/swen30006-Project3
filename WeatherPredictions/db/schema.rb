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

ActiveRecord::Schema.define(version: 20150513013132) do

  create_table "measurements", force: :cascade do |t|
    t.string   "condition"
    t.string   "time"
    t.float    "precitipation"
    t.float    "wind_direction"
    t.float    "wind_speed"
    t.float    "temperature"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "weather_stations", force: :cascade do |t|
    t.string   "name"
    t.integer  "postal_code"
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "measurement_id"
  end

  add_index "weather_stations", ["measurement_id"], name: "index_weather_stations_on_measurement_id"

end