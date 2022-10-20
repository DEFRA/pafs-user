# frozen_string_literal: true

PafsCore.configure do |config|
  config.complete_page_feedback_uri = "https://www.gov.uk/done/flood-and-coastal-defence-funding-submit-a-project"
  config.banner_feedback_uri = "http://www.smartsurvey.co.uk/s/PAFSGDS/"

  # Configure airbrake, which is done via the engine using defra_ruby_alert
  config.airbrake_enabled = ENV.key?("AIRBRAKE_PROJECT_KEY")
  config.airbrake_host = ENV.fetch("AIRBRAKE_HOST", nil)
  config.airbrake_project_key = ENV.fetch("AIRBRAKE_PROJECT_KEY", nil)
  config.airbrake_blocklist = [/password/i, /authorization/i]
end

PafsCore.start_airbrake
