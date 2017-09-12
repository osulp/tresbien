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

ActiveRecord::Schema.define(version: 20170912211137) do

  create_table "accountings", force: :cascade do |t|
    t.string "index"
    t.string "fund"
    t.string "organization"
    t.string "account"
    t.string "program"
    t.string "activity"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reimbursement_request_id"
    t.index ["reimbursement_request_id"], name: "index_accountings_on_reimbursement_request_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer "reimbursement_request_id"
    t.index ["reimbursement_request_id"], name: "index_attachments_on_reimbursement_request_id"
  end

  create_table "descriptions", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
  end

  create_table "expense_airfares", force: :cascade do |t|
    t.datetime "from_date"
    t.datetime "to_date"
    t.string "from_location"
    t.string "to_location"
    t.text "notes"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reimbursement_request_id"
    t.index ["reimbursement_request_id"], name: "index_expense_airfares_on_reimbursement_request_id"
  end

  create_table "expense_mileages", force: :cascade do |t|
    t.datetime "from_date"
    t.datetime "to_date"
    t.string "from_city"
    t.string "from_state"
    t.string "to_city"
    t.string "to_state"
    t.integer "miles"
    t.boolean "round_trip"
    t.text "notes"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reimbursement_request_id"
    t.index ["reimbursement_request_id"], name: "index_expense_mileages_on_reimbursement_request_id"
  end

  create_table "expense_others", force: :cascade do |t|
    t.datetime "from_date"
    t.datetime "to_date"
    t.text "notes"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expense_type_id"
    t.integer "reimbursement_request_id"
    t.index ["expense_type_id"], name: "index_expense_others_on_expense_type_id"
    t.index ["reimbursement_request_id"], name: "index_expense_others_on_reimbursement_request_id"
  end

  create_table "expense_types", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reimbursement_requests", force: :cascade do |t|
    t.string "identifier"
    t.float "itinerary_total"
    t.float "mileage_total"
    t.float "airfare_total"
    t.float "other_total"
    t.float "accounting_total"
    t.float "grand_total"
    t.float "claiming_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "claimant_id"
    t.integer "certifier_id"
    t.time "depart_time"
    t.time "return_time"
    t.boolean "non_resident_alien"
    t.text "business_notes_and_purpose"
    t.string "address"
    t.string "status"
    t.integer "description_id"
    t.index ["certifier_id"], name: "index_reimbursement_requests_on_certifier_id"
    t.index ["claimant_id"], name: "index_reimbursement_requests_on_claimant_id"
    t.index ["description_id"], name: "index_reimbursement_requests_on_description_id"
  end

  create_table "status_comments", force: :cascade do |t|
    t.text "comment"
    t.integer "reimbursement_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["reimbursement_request_id"], name: "index_status_comments_on_reimbursement_request_id"
    t.index ["user_id"], name: "index_status_comments_on_user_id"
  end

  create_table "travel_cities", force: :cascade do |t|
    t.datetime "from_date"
    t.datetime "to_date"
    t.string "city"
    t.string "state"
    t.boolean "include_meals"
    t.string "hotel_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reimbursement_request_id"
    t.string "country"
    t.index ["reimbursement_request_id"], name: "index_travel_cities_on_reimbursement_request_id"
  end

  create_table "travel_itineraries", force: :cascade do |t|
    t.datetime "date"
    t.string "city"
    t.string "state"
    t.string "break"
    t.string "lunch"
    t.string "dinner"
    t.string "hotel"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reimbursement_request_id"
    t.string "country"
    t.index ["reimbursement_request_id"], name: "index_travel_itineraries_on_reimbursement_request_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "pidm"
    t.boolean "certifier", default: false
    t.string "full_name"
    t.string "activity_code"
    t.string "osu_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
