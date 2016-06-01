# frozen_string_literal: true
class ResetPasswordController < ApplicationController
  def reset
    redirect_to pafs_core.projects_path unless flash[:email].present?
  end
end
