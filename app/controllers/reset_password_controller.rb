# frozen_string_literal: true

class ResetPasswordController < ApplicationController
  def reset
    redirect_to pafs_core.projects_path if flash[:email].blank?
  end
end
