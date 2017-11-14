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

ActiveRecord::Schema.define(version: 20171114012142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donation_types", force: :cascade do |t|
    t.string "type_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donations", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "project_id"
    t.integer "quantity_requested"
    t.integer "quantity_received", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_donations_on_item_id"
    t.index ["project_id"], name: "index_donations_on_project_id"
  end

  create_table "donors", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.integer "zip_code", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_confirmation"
  end

  create_table "events", force: :cascade do |t|
    t.string "event_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "followings", force: :cascade do |t|
    t.bigint "donor_id"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donor_id"], name: "index_followings_on_donor_id"
    t.index ["organization_id"], name: "index_followings_on_organization_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "item_name"
    t.string "image"
    t.bigint "donation_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donation_type_id"], name: "index_items_on_donation_type_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "organization_name", null: false
    t.integer "tax_code", null: false
    t.string "email", null: false
    t.string "url"
    t.text "mission_statement"
    t.string "password_digest"
    t.bigint "category_id", null: false
    t.string "organization_logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["category_id"], name: "index_organizations_on_category_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name", null: false
    t.string "street_address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.integer "zip_code", null: false
    t.text "description", null: false
    t.bigint "organization_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_projects_on_event_id"
    t.index ["organization_id"], name: "index_projects_on_organization_id"
  end

end
