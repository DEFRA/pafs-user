# frozen_string_literal: true

PafsCore::BootstrapsController.class_eval do
  helper ::ApplicationHelper
  layout ->(_) { "pafs" }

  # adding this here as pafs_core doesn't know about Devise
  before_action :authenticate_user!
end
