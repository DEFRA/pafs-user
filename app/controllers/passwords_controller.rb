# frozen_string_literal: true
class PasswordsController < Devise::PasswordsController
  # POST override the create method to prevent giving clues
  # to whether the email address exists / is registered
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    # whether successful or not we carry on
    # so we don't give away whether the email is registered or not
    if resource_params.fetch(:email, nil).present?
      flash[:email] = resource_params.fetch(:email)
      redirect_to after_password_reset_path
    else
      # they haven't provided an email address so prompt them for it
      respond_with(resource)
    end
  end
end
