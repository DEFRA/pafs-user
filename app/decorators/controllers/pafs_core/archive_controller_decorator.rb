# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
PafsCore::ArchivesController.class_eval do
  helper ::ApplicationHelper
  layout ->(_) { "pafs" }

  # adding this here as pafs_core doesn't know about Devise
  before_action :authenticate_user!
end
