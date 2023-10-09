# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module Pafs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.autoload_paths << Rails.root.join("lib")

    # load decorators
    config.to_prepare do
      # Exclude these from autoloading as we are loading them manually:
      Rails.autoloaders.main.ignore(Rails.root.join("app/decorators"))

      Rails.root.glob("app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # load files from nested directories
    config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.{rb,yml}").to_s]
    # add any locale files from pafs_core
    config.i18n.load_path += Dir["#{`bundle info pafs_core`.chomp}/config/locales/**/*.yml"]

    config.action_view.field_error_proc = proc { |t, _i| t }

    # active job
    config.active_job.queue_adapter = :sucker_punch

    # exception handling
    config.exceptions_app = routes

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
