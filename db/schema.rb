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

ActiveRecord::Schema.define(version: 2020_10_22_165147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "offers", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.string "limitations", default: "", null: false
    t.string "redemption", default: "", null: false
    t.string "location", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "office_hours", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "participant_id"
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "application_user_ids", default: [], null: false, array: true
  end

  create_table "projects", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.string "participants", default: "", null: false
    t.string "looking_for", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "volunteer_location", default: "", null: false
    t.string "contact", default: "", null: false
    t.boolean "highlight", default: false, null: false
    t.string "progress", default: "", null: false
    t.string "docs_and_demo", default: "", null: false
    t.string "number_of_volunteers", default: "", null: false
    t.string "links", default: ""
    t.string "status", default: "", null: false
    t.boolean "accepting_volunteers", default: true
    t.string "short_description", default: "", null: false
    t.string "target_country", default: "", null: false
    t.string "target_location", default: "", null: false
    t.string "organization_status", default: "", null: false
    t.string "ein"
    t.string "organization", default: ""
    t.string "level_of_urgency", default: "", null: false
    t.string "start_date", default: ""
    t.string "end_date", default: ""
    t.string "compensation", default: ""
    t.string "organization_mission"
    t.boolean "organization_registered"
    t.boolean "end_date_recurring"
    t.string "level_of_exposure"
    t.boolean "background_screening_required"
  end

  create_table "success_stories", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.text "links"
    t.text "project_ids"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "highlight", default: false, null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "about", default: "", null: false
    t.string "location", default: "", null: false
    t.string "profile_links", default: "", null: false
    t.boolean "visibility", default: false
    t.string "name", default: "", null: false
    t.string "level_of_availability"
    t.boolean "pair_with_projects", default: false
    t.boolean "deactivated", default: false, null: false
    t.text "office_hour_description"
    t.boolean "newsletter_consent"
    t.string "phone", default: ""
    t.string "affiliation", default: ""
    t.string "resume", default: ""
    t.string "remote_location", default: ""
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "volunteer_groups", force: :cascade do |t|
    t.integer "project_id"
    t.integer "assigned_user_ids", default: [], null: false, array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "volunteers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "note", default: "", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "taggings", "tags"
end
