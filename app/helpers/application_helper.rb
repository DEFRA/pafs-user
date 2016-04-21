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
    f = Rails.root.join('REVISION')
    if File.exists? f
      render file: f
    else
      %x(git rev-parse --short HEAD)
    end
  end
end
