class BasicStep < SimpleDelegator
  def step_name
    self.class.name.chomp('Step').underscore
  end

  def view_path
    "projects/steps/#{self.class.name.underscore}"
  end
end
