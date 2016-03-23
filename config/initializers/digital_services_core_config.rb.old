# For all available parameters see digital_services_core gem :
#
#         lib/digital_services_core/configuration.rb
#
DigitalServicesCore.setup do |config|

  # The subdomains used in links for password reset and other e-mails sent by
  # the Devise authentication component.
  config.public_subdomain = 'localhost'


  # This is a nested template that ultimately calls the gov uk template layout
  # This allows us to auto insert code into any of the hooks provided by the GDS layout.
  config.layout = "pafs"

  # Attempt to pick up the Google Tag Manager ID from an environment variable.
  # If the variable is not set, we cannot use Google Analytics.
  config.google_tag_manager_id = ENV["DSC_FRONTEND_GOOGLE_TAGMANAGER_ID"]

  # Tracking using Google Analytics. As noted above, we can only do this if we
  # know the Google Tag Manager ID.  Additionally, whilst we want to do this
  # in production, it is optional elsewhere.
  config.use_google_analytics = false

  unless config.google_tag_manager_id.blank?
    config.use_google_analytics =
      (ENV["DSC_FRONTEND_USE_GOOGLE_ANALYTICS"] == "true") ||
        Rails.env.production?
  end

  # The phone number shown on the certificate and used in e-mails
  # sent by the application.
  config.services_phone = ENV["DSC_SERVICES_PHONE"]

  # AddressFacade Lookup Service
  # config.address_facade_server  = Rails.application.secrets.address_facade_server
  # config.address_facade_port    = Rails.application.secrets.address_facade_port
  # config.address_facade_url     = '/address-service/v1/addresses'
  #
  # config.address_facade_client_id = Rails.application.secrets.address_facade_client_id
  # config.address_facade_key       = Rails.application.secrets.address_facade_key

end
