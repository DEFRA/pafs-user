# frozen_string_literal: true

PafsCore::AccountRequestsController.class_eval do
  helper ApplicationHelper
  layout ->(_) { "pafs" }
end
