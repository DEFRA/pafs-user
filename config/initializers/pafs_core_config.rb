PafsCore.configure do |config|
  config.complete_page_feedback_uri = "https://www.gov.uk/done/flood-and-coastal-defence-funding-submit-a-project"
  config.banner_feedback_uri = "http://www.smartsurvey.co.uk/s/PAFSGDS/"

  # Configure airbrake, which is done via the engine using defra_ruby_alert
  config.airbrake_enabled = ENV.key?("AIRBRAKE_PROJECT_KEY")
  config.airbrake_host = ENV["AIRBRAKE_HOST"]
  config.airbrake_project_key = ENV["AIRBRAKE_PROJECT_KEY"]
  config.airbrake_blocklist = [/password/i, /authorization/i]
end
