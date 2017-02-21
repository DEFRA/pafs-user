require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pafs
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')

    # load decorators
    config.to_prepare do
      Dir.glob(File.join(Rails.root, "app/decorators", "**/*_decorator*.rb")).each do |c|
        require_dependency(c)
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # load files from nested directories
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    # add any locale files from pafs_core
    config.i18n.load_path += Dir["#{%x[bundle show pafs_core].chomp}/config/locales/**/*.yml"]

    # config.i18n.default_locale = :de

    config.action_view.field_error_proc = Proc.new { |t, i| t }

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # active job
    config.active_job.queue_adapter = :sucker_punch

    # exception handling
    config.exceptions_app = self.routes
  end
end
