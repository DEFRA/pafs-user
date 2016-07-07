# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
class ApplicationController < ActionController::Base
  helper PafsCore::Engine.helpers
   # This is a nested template that ultimately calls the gov uk template layout
  # This allows us to auto insert code into any of the hooks provided by the GDS layout.
  layout ->(_) { "pafs" }
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
