class ProjectService
  def new_project
    Project.new(reference_number: generate_reference_number)
  end

  def find_project(id)
    Project.find_by(reference_number: id)
  end

  def generate_reference_number
    "P#{SecureRandom.hex[0..5].upcase}"
  end

end

