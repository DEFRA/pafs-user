class ProjectsController < ApplicationController

  def index
    #
    # dashboard page ?
    # (filterable) list of projects
  end

  def new
    # start a new project
    @project = project_navigator.start_new_project
    render @project.view_path
  end

  # GET
  def step
    # edit step
    @project = project_navigator.find_project_step(params[:id], params[:step]) 
    # we want to go to the page in the process requested in the 
    # params[:step] part of the URL and display the appropriate form
    render @project.view_path
  end

  # PATCH
  def save
    # submit data for the current step and continue or exit

    # if request is exit redirect to summary or dashboard?
    # else go to next step
    @project = project_navigator.find_project_step(params[:id], params[:step])
    if @project.update_project(params)
      redirect_to step_path(id: @project.to_param, step: @project.step)
    else
      render @project.view_path
    end
  end

private
  def project_navigator
    # TODO: pass current_user to ProjectNavigator constructor
    @project_navigator ||= ProjectNavigator.new # current_user 
  end
end
