require 'rails_helper'

RSpec.describe ProjectNavigator do

  describe ".first_step" do
    it "returns the identifier of first step in the journey" do
      expect(subject.first_step).to eq(described_class::STEPS.first)
    end
  end

  describe ".last_step" do
    it "returns the identifier of last step in the journey" do
      expect(subject.last_step).to eq(described_class::STEPS.last)
    end
  end

  describe ".start_new_project" do
    it "finds a project in the database by reference number and returns a decorator for the first step of the process" do
      p = nil
      expect { p = subject.start_new_project }.to change{Project.count}.by(1)
      expect(p).to respond_to :reference_number
    end
  end

  describe ".find_project_step" do
    let(:project) { subject.start_new_project }
    it "finds a project in the database by reference number and returns a decorator for the specified step of the process" do
      p = subject.find_project_step(project.to_param, subject.last_step)
      expect(p).to respond_to :reference_number
      expect(p.step).to eq(subject.last_step)
    end

    it "raises ActiveRecord::RecordNotFound for an invalid :reference_number" do
      expect { subject.find_project_step("123", subject.last_step) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "raises ActiveRecord::RecordNotFound for an invalid :step" do
      expect { subject.find_project_step(project, :wigwam) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

