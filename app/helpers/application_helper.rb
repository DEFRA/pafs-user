# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
module ApplicationHelper
  def set_page_title(title)
    return unless title.present?

    stripped_title = title.gsub(/’/, %{'})

    if content_for? :page_title
      content_for :page_title, " | #{stripped_title}"
    else
      content_for :page_title, "GOV.UK | #{stripped_title}"
    end

    title
  end

  def revision_hash
    Rails.application.config.x.revision
  end

  def migrate_devise_errors_for(resource)
    # move flash messages and resource.errors to :base
    resource.errors.add(:base, flash[:alert]) if flash[:alert].present?

    if resource.errors[:password].any?
      resource.errors.full_messages_for(:password).each { |m| resource.errors.add(:base, m) }
    elsif resource.errors[:password_confirmation].any?
      # only add :password_confirmation errors if there are no :password errors
      resource.errors.full_messages_for(:password_confirmation).each { |m| resource.errors.add(:base, m) }
    end
    resource.errors.delete(:password)
    resource.errors.delete(:password_confirmation)
  end
end
