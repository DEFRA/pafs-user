class ProjectNameStep < BasicStep
  attr_reader :step
  # provide link to previous / next step 
  # delegate to project
  def update_project(params)
    result = __getobj__.update(task_params(params))

    @step = :step_two if result

    result
  end

  def step
    @step ||= :project_name
  end

  def task_params(params)
    ActionController::Parameters.new(params).require(:project).permit(:name)
  end
end

