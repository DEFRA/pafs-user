class ProjectNavigator

  # add 'pages' or 'steps' to the STEPS list
  # NOTE: STEPS.first and STEPS.last are used to determine the start
  # and end points for the user's journey (although we can change this)
  STEPS = [ :project_name ]

  # TODO: once devise is set up
  #
  # attr_reader :user
  # def initialize(user)
  #   @user = user
  # end

  def first_step
    STEPS.first
  end

  def last_step
    STEPS.last
  end

  def start_new_project
    # we will need to position a project so that it 'belongs' somewhere
    # and is 'owned' by a user.  I envisage that we would use the 
    # current_user passed into the constructor to get this information.
    project = project_service.create_project
    Object::const_get("#{first_step.to_s.camelcase}Step").new project
  end

  def find_project_step(id, step)
    raise ActiveRecord::RecordNotFound.new("Unknown step [#{step}]") unless STEPS.include?(step.to_sym)
    # retrieve and wrap project
    Object::const_get("#{step.to_s.camelcase}Step").new project_service.find_project(id)
  end

private
  def project_service
    @project_service ||= ProjectService.new # user
  end

end

