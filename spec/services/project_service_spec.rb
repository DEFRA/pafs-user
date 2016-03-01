require 'rails_helper'

RSpec.describe ProjectService do

  describe ".new_project" do
    it "builds a new project model without saving to the database" do
      p = nil
      expect { p = subject.new_project }.to_not change{Project.count}
      expect(p).to be_a Project
    end
  end

  describe ".create_project" do
    it "creates a new project and saves to the database" do
      p = nil
      expect { p = subject.create_project }.to change{Project.count}.by(1)
      expect(p).to be_a Project
    end
  end

  describe ".find_project" do
    it "finds a project in the database by reference number" do
      p = subject.create_project
      expect(subject.find_project(p.to_param)).to eq(p)
    end

    it "raises ActiveRecord::RecordNotFound for an invalid reference_number" do
      expect { subject.find_project("123") }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ".generate_reference_number" do
    let(:reference_number) { subject.generate_reference_number }
    it "returns a 7 character string starting with the letter P" do
      expect(reference_number.length).to eq(7)
      expect(reference_number.start_with?('P')).to be true
    end
  end
end

