# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include PafsCore::CustomHeaders

  helper PafsCore::Engine.helpers

  # This is a nested template that ultimately calls the gov uk template layout
  # This allows us to auto insert code into any of the hooks provided by the GDS layout.
  layout ->(_) { "pafs" }
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :cache_busting

  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder

  private

  def custom_headers
    response_headers!(response)
  end

end
