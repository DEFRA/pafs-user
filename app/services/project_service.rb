class ProjectService
  def new_project
    project = Project.new(reference_number: generate_reference_number)
  end

  def self.generate_reference_number
    "P#{SecureRandom.hex(6).upcase}"
  end

end

