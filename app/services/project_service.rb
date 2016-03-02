class ProjectService

  # TODO: once devise is set up
  # attr_reader :user
  # def initialize(user)
  #   @user = user
  # end

  def new_project
    Project.new(initial_attributes)
  end

  def create_project
    Project.create(initial_attributes)
  end

  def find_project(id)
    Project.find_by!(reference_number: id)
  end

  def generate_reference_number
    "P#{SecureRandom.hex[0..5].upcase}"
  end

private
  def initial_attributes
    {
      reference_number: generate_reference_number,
      version: 0,
      # TODO: owner: user
    }
  end
end

