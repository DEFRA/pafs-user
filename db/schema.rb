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

ActiveRecord::Schema.define(version: 20160413153105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dsc_roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "dsc_roles", ["name", "resource_type", "resource_id"], name: "index_dsc_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "dsc_roles", ["name"], name: "index_dsc_roles_on_name", using: :btree

  create_table "dsc_user_versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "dsc_user_versions", ["item_type", "item_id"], name: "index_dsc_user_versions_on_item_type_and_item_id", using: :btree

  create_table "dsc_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "role_names"
  end

  add_index "dsc_users", ["email"], name: "index_dsc_users_on_email", unique: true, using: :btree
  add_index "dsc_users", ["reset_password_token"], name: "index_dsc_users_on_reset_password_token", unique: true, using: :btree

  create_table "dsc_users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "dsc_users_roles", ["user_id", "role_id"], name: "index_dsc_users_roles_on_user_id_and_role_id", using: :btree

  create_table "pafs_core_account_requests", force: :cascade do |t|
    t.string   "first_name",       default: "",    null: false
    t.string   "last_name",        default: "",    null: false
    t.string   "email",            default: "",    null: false
    t.string   "organisation",     default: "",    null: false
    t.string   "job_title"
    t.string   "telephone_number"
    t.string   "slug"
    t.boolean  "terms_accepted",   default: false, null: false
    t.boolean  "provisioned",      default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "pafs_core_account_requests", ["email"], name: "index_pafs_core_account_requests_on_email", unique: true, using: :btree
  add_index "pafs_core_account_requests", ["slug"], name: "index_pafs_core_account_requests_on_slug", unique: true, using: :btree

  create_table "pafs_core_area_projects", force: :cascade do |t|
    t.integer  "area_id",                    null: false
    t.integer  "project_id",                 null: false
    t.boolean  "owner",      default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "pafs_core_area_projects", ["area_id"], name: "index_pafs_core_area_projects_on_area_id", using: :btree
  add_index "pafs_core_area_projects", ["project_id"], name: "index_pafs_core_area_projects_on_project_id", using: :btree

  create_table "pafs_core_areas", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.string   "area_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pafs_core_areas", ["name"], name: "index_pafs_core_areas_on_name", using: :btree

  create_table "pafs_core_projects", force: :cascade do |t|
    t.string   "reference_number",                        null: false
    t.integer  "version",                                 null: false
    t.string   "name"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "project_end_financial_year"
    t.string   "slug",                       default: "", null: false
  end

  add_index "pafs_core_projects", ["reference_number", "version"], name: "index_pafs_core_projects_on_reference_number_and_version", unique: true, using: :btree
  add_index "pafs_core_projects", ["slug"], name: "index_pafs_core_projects_on_slug", unique: true, using: :btree

  create_table "pafs_core_reference_counters", force: :cascade do |t|
    t.string   "rfcc_code",    default: "", null: false
    t.integer  "high_counter", default: 0,  null: false
    t.integer  "low_counter",  default: 0,  null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "pafs_core_reference_counters", ["rfcc_code"], name: "index_pafs_core_reference_counters_on_rfcc_code", unique: true, using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "reference_number", null: false
    t.integer  "version",          null: false
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "projects", ["reference_number", "version"], name: "index_projects_on_reference_number_and_version", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "job_title"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "dsc_users_roles", "dsc_roles", column: "role_id"
  add_foreign_key "dsc_users_roles", "dsc_users", column: "user_id"
end
