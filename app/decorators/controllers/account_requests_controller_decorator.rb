# frozen_string_literal: true

::AccountRequestsController.class_eval do # rubocop:disable Style/RedundantConstantBase
  helper ApplicationHelper
  layout ->(_) { "pafs" }
end
