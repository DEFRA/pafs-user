# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

module ApplicationHelper
  def revision_hash
    Rails.application.config.x.revision
  end

  def not_policy_page?(supplied_path)
    supplied_path != cookies_path && supplied_path != main_app.page_path("privacy_notice")
  end

  def migrate_devise_errors_for(resource)
    # move flash messages and resource.errors to :base
    resource.errors.add(:base, flash[:alert]) if flash[:alert].present?

    if resource.errors[:password].present?
      resource.errors.full_messages_for(:password).each { |m| resource.errors.add(:base, m) }
    elsif resource.errors[:password_confirmation].present?
      # only add :password_confirmation errors if there are no :password errors
      resource.errors.full_messages_for(:password_confirmation).each { |m| resource.errors.add(:base, m) }
    end
    resource.errors.delete(:password)
    resource.errors.delete(:password_confirmation)
  end

  def show_return_to_overview?
    ((controller_name == "projects" && action_name != "index" && action_name != "show") ||
      (controller_name == "downloads" && action_name == "index")) &&
      defined?(:project) &&
      !@project.nil?
  end
end
