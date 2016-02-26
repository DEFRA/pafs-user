class ProjectsController < ApplicationController
  before_action :set_project, only: [:step, :save]

  def index
    # dashboard page
    # includes list of projects
  end

  def new
    @project = project_service.new_project
  end

  # GET
  def step
    # edit step

    # we want to go to the page in the process requested in the 
    # params[:step] part of the URL and display the appropriate form
    render 'projects/steps/project_name'
  end

  # PATCH
  def save
    # submit data for the current step and continue or exit
  end


  private
    def set_project
      @project = project_service.find_project(params[:id])
    end

    def project_params
    end

    def project_service
      @project_service ||= ProjectService.new
    end
end
