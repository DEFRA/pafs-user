# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_07_23_122034) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "old_passwords", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.string "password_archivable_type", null: false
    t.integer "password_archivable_id", null: false
    t.datetime "created_at", precision: nil
    t.index ["password_archivable_type", "password_archivable_id"], name: "index_password_archivableddu"
  end

  create_table "pafs_core_account_requests", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "organisation", default: "", null: false
    t.string "job_title"
    t.string "telephone_number"
    t.string "slug"
    t.boolean "terms_accepted", default: false, null: false
    t.boolean "provisioned", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_pafs_core_account_requests_on_email", unique: true
    t.index ["slug"], name: "index_pafs_core_account_requests_on_slug", unique: true
  end

  create_table "pafs_core_area_downloads", force: :cascade do |t|
    t.integer "area_id"
    t.integer "user_id"
    t.datetime "requested_on", precision: nil
    t.integer "number_of_proposals"
    t.string "fcerm1_filename"
    t.string "benefit_areas_filename"
    t.string "moderation_filename"
    t.integer "number_of_proposals_with_moderation"
    t.string "status", default: "empty", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "funding_calculator_filename"
    t.index ["area_id"], name: "index_pafs_core_area_downloads_on_area_id"
  end

  create_table "pafs_core_area_projects", force: :cascade do |t|
    t.integer "area_id", null: false
    t.integer "project_id", null: false
    t.boolean "owner", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["area_id"], name: "index_pafs_core_area_projects_on_area_id"
    t.index ["project_id"], name: "index_pafs_core_area_projects_on_project_id"
  end

  create_table "pafs_core_areas", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.string "area_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "sub_type"
    t.string "identifier"
    t.date "end_date"
    t.index ["name"], name: "index_pafs_core_areas_on_name"
  end

  create_table "pafs_core_asite_files", force: :cascade do |t|
    t.integer "asite_submission_id"
    t.string "filename", null: false
    t.string "checksum", null: false
  end

  create_table "pafs_core_asite_submissions", force: :cascade do |t|
    t.integer "project_id"
    t.datetime "email_sent_at", precision: nil, null: false
    t.datetime "confirmation_received_at", precision: nil
    t.string "status", default: "created", null: false
  end

  create_table "pafs_core_bootstraps", force: :cascade do |t|
    t.boolean "fcerm_gia"
    t.boolean "local_levy"
    t.string "name"
    t.string "project_type"
    t.integer "project_end_financial_year"
    t.string "slug", null: false
    t.integer "creator_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "rma_name"
    t.index ["slug"], name: "index_pafs_core_bootstraps_on_slug", unique: true
  end

  create_table "pafs_core_coastal_erosion_protection_outcomes", force: :cascade do |t|
    t.integer "project_id"
    t.integer "financial_year", null: false
    t.integer "households_at_reduced_risk"
    t.integer "households_protected_from_loss_in_next_20_years"
    t.integer "households_protected_from_loss_in_20_percent_most_deprived"
    t.integer "non_residential_properties"
    t.index ["financial_year"], name: "cep_outcomes_on_financial_year"
    t.index ["project_id", "financial_year"], name: "cep_outcomes_on_project_id_and_financial_year"
    t.index ["project_id"], name: "cep_outcomes_on_project_id"
  end

  create_table "pafs_core_flood_protection2040_outcomes", force: :cascade do |t|
    t.integer "project_id"
    t.integer "financial_year", null: false
    t.integer "households_at_reduced_risk"
    t.integer "moved_from_very_significant_and_significant_to_moderate_or_low"
    t.integer "households_protected_from_loss_in_20_percent_most_deprived"
    t.integer "non_residential_properties"
  end

  create_table "pafs_core_flood_protection_outcomes", force: :cascade do |t|
    t.integer "project_id"
    t.integer "financial_year", null: false
    t.integer "households_at_reduced_risk"
    t.integer "moved_from_very_significant_and_significant_to_moderate_or_low"
    t.integer "households_protected_from_loss_in_20_percent_most_deprived"
    t.integer "households_protected_through_plp_measures"
    t.integer "non_residential_properties"
    t.index ["financial_year"], name: "fp_outcomes_on_financial_year"
    t.index ["project_id", "financial_year"], name: "fp_outcomes_on_project_id_and_financial_year"
    t.index ["project_id"], name: "fp_outcomes_on_project_id"
  end

  create_table "pafs_core_funding_contributors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "contributor_type"
    t.integer "funding_value_id"
    t.bigint "amount"
    t.boolean "secured", default: false, null: false
    t.boolean "constrained", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["contributor_type"], name: "index_pafs_core_funding_contributors_on_contributor_type"
    t.index ["funding_value_id", "contributor_type"], name: "funding_contributors_on_funding_value_id_and_type"
    t.index ["funding_value_id"], name: "index_pafs_core_funding_contributors_on_funding_value_id"
  end

  create_table "pafs_core_funding_values", force: :cascade do |t|
    t.integer "project_id"
    t.integer "financial_year", null: false
    t.bigint "fcerm_gia"
    t.bigint "local_levy"
    t.bigint "internal_drainage_boards"
    t.bigint "public_contributions"
    t.bigint "private_contributions"
    t.bigint "other_ea_contributions"
    t.bigint "not_yet_identified"
    t.bigint "total", default: 0, null: false
    t.bigint "asset_replacement_allowance"
    t.bigint "environment_statutory_funding"
    t.bigint "frequently_flooded_communities"
    t.bigint "other_additional_grant_in_aid"
    t.bigint "other_government_department"
    t.bigint "recovery"
    t.bigint "summer_economic_fund"
    t.index ["financial_year"], name: "index_pafs_core_funding_values_on_financial_year"
    t.index ["project_id", "financial_year"], name: "funding_values_on_project_id_and_financial_year"
    t.index ["project_id"], name: "index_pafs_core_funding_values_on_project_id"
  end

  create_table "pafs_core_projects", force: :cascade do |t|
    t.string "reference_number", null: false
    t.integer "version", null: false
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "project_end_financial_year"
    t.string "slug", default: "", null: false
    t.integer "start_outline_business_case_month"
    t.integer "start_outline_business_case_year"
    t.integer "award_contract_month"
    t.integer "award_contract_year"
    t.integer "start_construction_month"
    t.integer "start_construction_year"
    t.integer "ready_for_service_month"
    t.integer "ready_for_service_year"
    t.boolean "fcerm_gia"
    t.boolean "local_levy"
    t.boolean "internal_drainage_boards"
    t.boolean "public_contributions"
    t.string "public_contributor_names"
    t.boolean "private_contributions"
    t.string "private_contributor_names"
    t.boolean "other_ea_contributions"
    t.string "other_ea_contributor_names"
    t.boolean "growth_funding"
    t.boolean "not_yet_identified"
    t.boolean "could_start_early"
    t.integer "earliest_with_gia_month"
    t.integer "earliest_with_gia_year"
    t.boolean "fluvial_flooding"
    t.boolean "tidal_flooding"
    t.boolean "groundwater_flooding"
    t.boolean "surface_water_flooding"
    t.boolean "coastal_erosion"
    t.string "main_risk"
    t.string "project_type"
    t.string "funding_calculator_file_name"
    t.string "funding_calculator_content_type"
    t.integer "funding_calculator_file_size"
    t.datetime "funding_calculator_updated_at", precision: nil
    t.text "project_location", default: [], array: true
    t.integer "project_location_zoom_level", default: 15
    t.text "benefit_area"
    t.text "benefit_area_centre", array: true
    t.integer "benefit_area_zoom_level"
    t.datetime "submitted_at", precision: nil
    t.integer "flood_protection_before"
    t.integer "flood_protection_after"
    t.integer "coastal_protection_before"
    t.integer "coastal_protection_after"
    t.string "urgency_reason"
    t.string "urgency_details"
    t.string "approach"
    t.integer "creator_id"
    t.boolean "improve_surface_or_groundwater"
    t.float "improve_surface_or_groundwater_amount"
    t.boolean "improve_river"
    t.boolean "improve_spa_or_sac"
    t.boolean "improve_sssi"
    t.boolean "improve_hpi"
    t.float "improve_habitat_amount"
    t.float "improve_river_amount"
    t.boolean "create_habitat"
    t.float "create_habitat_amount"
    t.boolean "remove_fish_barrier"
    t.boolean "remove_eel_barrier"
    t.float "fish_or_eel_amount"
    t.boolean "funding_sources_visited", default: false
    t.string "benefit_area_file_name"
    t.string "benefit_area_content_type"
    t.integer "benefit_area_file_size"
    t.datetime "benefit_area_file_updated_at", precision: nil
    t.boolean "sea_flooding"
    t.string "region"
    t.string "parliamentary_constituency"
    t.boolean "strategic_approach"
    t.float "raw_partnership_funding_score"
    t.float "adjusted_partnership_funding_score"
    t.float "pv_whole_life_costs"
    t.float "pv_whole_life_benefits"
    t.integer "duration_of_benefits"
    t.float "hectares_of_net_water_dependent_habitat_created"
    t.float "hectares_of_net_water_intertidal_habitat_created"
    t.float "kilometres_of_protected_river_improved"
    t.string "county"
    t.datetime "urgency_details_updated_at", precision: nil
    t.string "grid_reference"
    t.boolean "reservoir_flooding"
    t.boolean "consented", default: false, null: false
    t.boolean "reduced_risk_of_households_for_floods", default: false, null: false
    t.boolean "reduced_risk_of_households_for_coastal_erosion", default: false, null: false
    t.string "rma_name"
    t.datetime "submitted_to_pol", precision: nil
    t.string "confidence_homes_better_protected"
    t.string "confidence_homes_by_gateway_four"
    t.string "confidence_secured_partnership_funding"
    t.bigint "carbon_cost_build"
    t.bigint "carbon_cost_operation"
    t.boolean "natural_flood_risk_measures_included"
    t.boolean "river_restoration"
    t.boolean "floodplain_restoration"
    t.boolean "leaky_barriers"
    t.boolean "offline_flood_storage_areas"
    t.boolean "cross_slope_woodland"
    t.boolean "catchment_woodland"
    t.boolean "riparian_woodland"
    t.boolean "floodplain_woodland"
    t.boolean "soil_and_land_management"
    t.boolean "land_and_headwater_drainage_management"
    t.boolean "runoff_pathway_management"
    t.boolean "saltmarsh_mudflats_and_managed_realignment"
    t.boolean "sand_dunes"
    t.boolean "beach_nourishment"
    t.string "other_flood_measures"
    t.float "natural_flood_risk_measures_cost"
    t.boolean "other_flood_measures_selected"
    t.boolean "environmental_benefits"
    t.boolean "intertidal_habitat"
    t.float "hectares_of_intertidal_habitat_created_or_enhanced"
    t.boolean "woodland"
    t.float "hectares_of_woodland_habitat_created_or_enhanced"
    t.boolean "wet_woodland"
    t.float "hectares_of_wet_woodland_habitat_created_or_enhanced"
    t.boolean "wetland_or_wet_grassland"
    t.float "hectares_of_wetland_or_wet_grassland_created_or_enhanced"
    t.boolean "grassland"
    t.float "hectares_of_grassland_habitat_created_or_enhanced"
    t.boolean "heathland"
    t.float "hectares_of_heathland_created_or_enhanced"
    t.boolean "ponds_lakes"
    t.float "hectares_of_pond_or_lake_habitat_created_or_enhanced"
    t.boolean "arable_land"
    t.float "hectares_of_arable_land_lake_habitat_created_or_enhanced"
    t.boolean "comprehensive_restoration"
    t.float "kilometres_of_watercourse_enhanced_or_created_comprehensive"
    t.boolean "partial_restoration"
    t.float "kilometres_of_watercourse_enhanced_or_created_partial"
    t.boolean "create_habitat_watercourse"
    t.float "kilometres_of_watercourse_enhanced_or_created_single"
    t.boolean "no_properties_affected_by_flooding_2040", default: false, null: false
    t.integer "complete_outline_business_case_month"
    t.integer "complete_outline_business_case_year"
    t.boolean "asset_replacement_allowance", default: false
    t.boolean "environment_statutory_funding", default: false
    t.boolean "frequently_flooded_communities", default: false
    t.boolean "other_additional_grant_in_aid", default: false
    t.boolean "other_government_department", default: false
    t.boolean "recovery", default: false
    t.boolean "summer_economic_fund", default: false
    t.integer "earliest_start_month"
    t.integer "earliest_start_year"
    t.string "updated_by_type"
    t.bigint "updated_by_id"
    t.integer "pending_earliest_start_month"
    t.integer "pending_earliest_start_year"
    t.integer "pending_financial_year"
    t.boolean "date_change_requires_confirmation"
    t.index ["name"], name: "index_pafs_core_projects_on_name", unique: true
    t.index ["reference_number", "version"], name: "index_pafs_core_projects_on_reference_number_and_version", unique: true
    t.index ["slug"], name: "index_pafs_core_projects_on_slug", unique: true
    t.index ["submitted_to_pol"], name: "index_pafs_core_projects_on_submitted_to_pol"
    t.index ["updated_by_type", "updated_by_id"], name: "index_pafs_core_projects_on_updated_by"
  end

  create_table "pafs_core_reference_counters", force: :cascade do |t|
    t.string "rfcc_code", default: "", null: false
    t.integer "high_counter", default: 0, null: false
    t.integer "low_counter", default: 0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["rfcc_code"], name: "index_pafs_core_reference_counters_on_rfcc_code", unique: true
  end

  create_table "pafs_core_states", force: :cascade do |t|
    t.integer "project_id"
    t.string "state", default: "draft", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "pafs_core_user_areas", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id", null: false
    t.integer "area_id", null: false
    t.boolean "primary", default: false
    t.index ["area_id"], name: "index_pafs_core_user_areas_on_area_id"
    t.index ["user_id"], name: "index_pafs_core_user_areas_on_user_id"
  end

  create_table "pafs_core_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at", precision: nil
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "job_title"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.integer "invitations_count", default: 0
    t.boolean "admin", default: false, null: false
    t.boolean "disabled", default: false, null: false
    t.string "unique_session_id", limit: 20
    t.index ["disabled"], name: "index_pafs_core_users_on_disabled"
    t.index ["email"], name: "index_pafs_core_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_pafs_core_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_pafs_core_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_pafs_core_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_pafs_core_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_pafs_core_users_on_unlock_token", unique: true
  end
end
