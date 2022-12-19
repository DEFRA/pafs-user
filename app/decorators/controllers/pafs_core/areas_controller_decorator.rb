# frozen_string_literal: true

PafsCore::AreasController.class_eval do
  helper ApplicationHelper
  layout ->(_) { "pafs" }

  # adding this here as pafs_core doesn't know about Devise
  before_action :authenticate_user!
  before_action :only_for_the_team

  def only_for_the_team
    redirect_to "/" unless ENV["ENABLE_USER_AREAS"]
  end
end
