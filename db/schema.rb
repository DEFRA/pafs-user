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

ActiveRecord::Schema.define(version: 20170403103416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "old_passwords", force: :cascade do |t|
    t.string   "encrypted_password",       null: false
    t.string   "password_archivable_type", null: false
    t.integer  "password_archivable_id",   null: false
    t.datetime "created_at"
  end

  add_index "old_passwords", ["password_archivable_type", "password_archivable_id"], name: "index_password_archivableddu", using: :btree

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
    t.string   "sub_type"
  end

  add_index "pafs_core_areas", ["name"], name: "index_pafs_core_areas_on_name", using: :btree

  create_table "pafs_core_asite_files", force: :cascade do |t|
    t.integer "asite_submission_id"
    t.string  "filename",            null: false
    t.string  "checksum",            null: false
  end

  create_table "pafs_core_asite_submissions", force: :cascade do |t|
    t.integer  "project_id"
    t.datetime "email_sent_at",                                null: false
    t.datetime "confirmation_received_at"
    t.string   "status",                   default: "created", null: false
  end

  create_table "pafs_core_bootstraps", force: :cascade do |t|
    t.boolean  "fcerm_gia"
    t.boolean  "local_levy"
    t.string   "name"
    t.string   "project_type"
    t.integer  "project_end_financial_year"
    t.string   "slug",                       null: false
    t.integer  "creator_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "pafs_core_bootstraps", ["slug"], name: "index_pafs_core_bootstraps_on_slug", unique: true, using: :btree

  create_table "pafs_core_coastal_erosion_protection_outcomes", force: :cascade do |t|
    t.integer "project_id"
    t.integer "financial_year",                                             null: false
    t.integer "households_at_reduced_risk"
    t.integer "households_protected_from_loss_in_next_20_years"
    t.integer "households_protected_from_loss_in_20_percent_most_deprived"
  end

  create_table "pafs_core_flood_protection_outcomes", force: :cascade do |t|
    t.integer "project_id"
    t.integer "financial_year",                                                 null: false
    t.integer "households_at_reduced_risk"
    t.integer "moved_from_very_significant_and_significant_to_moderate_or_low"
    t.integer "households_protected_from_loss_in_20_percent_most_deprived"
  end

  create_table "pafs_core_funding_values", force: :cascade do |t|
    t.integer "project_id"
    t.integer "financial_year",                                 null: false
    t.integer "fcerm_gia",                limit: 8
    t.integer "local_levy",               limit: 8
    t.integer "internal_drainage_boards", limit: 8
    t.integer "public_contributions",     limit: 8
    t.integer "private_contributions",    limit: 8
    t.integer "other_ea_contributions",   limit: 8
    t.integer "growth_funding",           limit: 8
    t.integer "not_yet_identified",       limit: 8
    t.integer "total",                    limit: 8, default: 0, null: false
  end

  create_table "pafs_core_program_upload_failures", force: :cascade do |t|
    t.integer  "program_upload_item_id"
    t.string   "field_name",             null: false
    t.string   "messages",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pafs_core_program_upload_failures", ["program_upload_item_id"], name: "idx_program_upload_failures", using: :btree

  create_table "pafs_core_program_upload_items", force: :cascade do |t|
    t.integer  "program_upload_id"
    t.string   "reference_number",  null: false
    t.boolean  "imported",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pafs_core_program_upload_items", ["program_upload_id"], name: "idx_program_upload_items", using: :btree

  create_table "pafs_core_program_uploads", force: :cascade do |t|
    t.string   "filename",                          null: false
    t.integer  "number_of_records",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",            default: "new"
  end

  add_index "pafs_core_program_uploads", ["status"], name: "pafs_core_upload_status", using: :btree

  create_table "pafs_core_projects", force: :cascade do |t|
    t.string   "reference_number",                                                 null: false
    t.integer  "version",                                                          null: false
    t.string   "name"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.integer  "project_end_financial_year"
    t.string   "slug",                                             default: "",    null: false
    t.integer  "start_outline_business_case_month"
    t.integer  "start_outline_business_case_year"
    t.integer  "award_contract_month"
    t.integer  "award_contract_year"
    t.integer  "start_construction_month"
    t.integer  "start_construction_year"
    t.integer  "ready_for_service_month"
    t.integer  "ready_for_service_year"
    t.boolean  "fcerm_gia"
    t.boolean  "local_levy"
    t.boolean  "internal_drainage_boards"
    t.boolean  "public_contributions"
    t.string   "public_contributor_names"
    t.boolean  "private_contributions"
    t.string   "private_contributor_names"
    t.boolean  "other_ea_contributions"
    t.string   "other_ea_contributor_names"
    t.boolean  "growth_funding"
    t.boolean  "not_yet_identified"
    t.boolean  "could_start_early"
    t.integer  "earliest_start_month"
    t.integer  "earliest_start_year"
    t.boolean  "fluvial_flooding"
    t.boolean  "tidal_flooding"
    t.boolean  "groundwater_flooding"
    t.boolean  "surface_water_flooding"
    t.boolean  "coastal_erosion"
    t.string   "main_risk"
    t.string   "project_type"
    t.string   "funding_calculator_file_name"
    t.string   "funding_calculator_content_type"
    t.integer  "funding_calculator_file_size"
    t.datetime "funding_calculator_updated_at"
    t.text     "project_location",                                 default: [],                 array: true
    t.integer  "project_location_zoom_level",                      default: 15
    t.text     "benefit_area"
    t.text     "benefit_area_centre",                                                           array: true
    t.integer  "benefit_area_zoom_level"
    t.datetime "submitted_at"
    t.integer  "flood_protection_before"
    t.integer  "flood_protection_after"
    t.integer  "coastal_protection_before"
    t.integer  "coastal_protection_after"
    t.string   "urgency_reason"
    t.string   "urgency_details"
    t.string   "approach"
    t.integer  "creator_id"
    t.boolean  "improve_surface_or_groundwater"
    t.float    "improve_surface_or_groundwater_amount"
    t.boolean  "improve_river"
    t.boolean  "improve_spa_or_sac"
    t.boolean  "improve_sssi"
    t.boolean  "improve_hpi"
    t.float    "improve_habitat_amount"
    t.float    "improve_river_amount"
    t.boolean  "create_habitat"
    t.float    "create_habitat_amount"
    t.boolean  "remove_fish_barrier"
    t.boolean  "remove_eel_barrier"
    t.float    "fish_or_eel_amount"
    t.boolean  "funding_sources_visited",                          default: false
    t.string   "benefit_area_file_name"
    t.string   "benefit_area_content_type"
    t.integer  "benefit_area_file_size"
    t.datetime "benefit_area_file_updated_at"
    t.boolean  "sea_flooding"
    t.string   "region"
    t.string   "parliamentary_constituency"
    t.boolean  "strategic_approach"
    t.float    "raw_partnership_funding_score"
    t.float    "adjusted_partnership_funding_score"
    t.float    "pv_whole_life_costs"
    t.float    "pv_whole_life_benefits"
    t.integer  "duration_of_benefits"
    t.float    "hectares_of_net_water_dependent_habitat_created"
    t.float    "hectares_of_net_water_intertidal_habitat_created"
    t.float    "kilometres_of_protected_river_improved"
    t.string   "county"
    t.datetime "urgency_details_updated_at"
    t.string   "grid_reference"
    t.boolean  "reservoir_flooding"
    t.boolean  "consented",                                        default: false, null: false
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

  create_table "pafs_core_states", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "state",      default: "draft", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pafs_core_user_areas", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id",                    null: false
    t.integer  "area_id",                    null: false
    t.boolean  "primary",    default: false
  end

  add_index "pafs_core_user_areas", ["area_id"], name: "index_pafs_core_user_areas_on_area_id", using: :btree
  add_index "pafs_core_user_areas", ["user_id"], name: "index_pafs_core_user_areas_on_user_id", using: :btree

  create_table "pafs_core_users", force: :cascade do |t|
    t.string   "email",                             default: "",    null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",                   default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "first_name",                        default: "",    null: false
    t.string   "last_name",                         default: "",    null: false
    t.string   "job_title"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",                 default: 0
    t.boolean  "admin",                             default: false, null: false
    t.boolean  "disabled",                          default: false, null: false
    t.string   "unique_session_id",      limit: 20
  end

  add_index "pafs_core_users", ["disabled"], name: "index_pafs_core_users_on_disabled", using: :btree
  add_index "pafs_core_users", ["email"], name: "index_pafs_core_users_on_email", unique: true, using: :btree
  add_index "pafs_core_users", ["invitation_token"], name: "index_pafs_core_users_on_invitation_token", unique: true, using: :btree
  add_index "pafs_core_users", ["invitations_count"], name: "index_pafs_core_users_on_invitations_count", using: :btree
  add_index "pafs_core_users", ["invited_by_id"], name: "index_pafs_core_users_on_invited_by_id", using: :btree
  add_index "pafs_core_users", ["reset_password_token"], name: "index_pafs_core_users_on_reset_password_token", unique: true, using: :btree
  add_index "pafs_core_users", ["unlock_token"], name: "index_pafs_core_users_on_unlock_token", unique: true, using: :btree

end
