require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Schoolsystem
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
config.encoding = "utf-8"
config.active_job.queue_adapter = :delayed_job
    # config.assets.enabled = true
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "codeprettifier")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "easypiechart")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "sparklines")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "form-toggle")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "fullcalendar")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "form-daterangepicker")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "charts-flot")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "pulsate")
    # config.assets.paths << Rails.root.join("app", "assets", "demo")
    # config.assets.paths << Rails.root.join("app", "assets", "demo", "variations")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "form-markdown", "css")

    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "codeprettifier")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "codeprettifier")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "codeprettifier")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "codeprettifier")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "codeprettifier")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "codeprettifier")
    # config.assets.paths << Rails.root.join("app", "assets", "plugins", "bootstrap","js")

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
