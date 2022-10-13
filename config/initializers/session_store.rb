# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store,
                                       key: "_pafs_session",
                                       expire_after: (Rails.env.development? ? 1.year : 30.minutes)
