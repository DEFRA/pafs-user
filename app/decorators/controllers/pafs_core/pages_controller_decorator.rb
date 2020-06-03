# frozen_string_literal: true

PafsCore::PagesController.class_eval do
  helper ::ApplicationHelper
  layout ->(_) { "pafs" }
end
