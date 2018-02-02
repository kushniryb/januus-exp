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

ActiveRecord::Schema.define(version: 20180202093551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "addresses", force: :cascade do |t|
    t.string "address"
    t.string "state"
    t.string "city"
    t.string "zip_code"
    t.bigint "excavator_id"
    t.index ["excavator_id"], name: "index_addresses_on_excavator_id"
  end

  create_table "excavators", force: :cascade do |t|
    t.string "company_name"
    t.boolean "manned"
    t.bigint "ticket_id"
    t.index ["ticket_id"], name: "index_excavators_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "request_id"
    t.integer "sequence_id"
    t.string "request_type"
    t.string "service_area"
    t.string "additional_service_areas", default: [], null: false, array: true
    t.datetime "response_due_at"
    t.geometry "zone", limit: {:srid=>0, :type=>"st_polygon"}
    t.index ["additional_service_areas"], name: "index_tickets_on_additional_service_areas", using: :gin
    t.index ["zone"], name: "index_tickets_on_zone", using: :gist
  end

end
