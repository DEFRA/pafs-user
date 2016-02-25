class ProjectsController < ApplicationController
  def index
    # dashboard page
    # includes list of projects
  end

  def new
    @project = project_service.new_project
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  private
    def project_params
    end

    def project_service
      @project_service ||= ProjectService.new
    end
end
