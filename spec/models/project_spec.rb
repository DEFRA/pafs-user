require 'rails_helper'

RSpec.describe Project, :type => :model do
  describe "@reference_number" do
    it "is required" do
      project = FactoryGirl.build(:project, reference_number: nil)
      expect(project.valid?).to be false
      expect(project.errors).to include(:reference_number)
    end

    it "is unique" do
      project = FactoryGirl.create(:project)
      project2 = FactoryGirl.build(:project)
      expect(project2.valid?).to be false
    end
  end
end

