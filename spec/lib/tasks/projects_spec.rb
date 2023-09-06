# frozen_string_literal: true

require "rails_helper"

RSpec.describe "projects" do

  describe "projects:import", type: :rake do
    let(:area_one) { create(:rma_area, name: "Council 1") }
    let(:area_two) { create(:rma_area, name: "Council 2") }
    let(:csv_file) { Rails.root.join("tmp/projects.csv") }

    before do
      # create a CSV file with test data
      CSV.open(csv_file, "wb") do |csv|
        csv << ["Project 1", "ANC401I/000A/007A", area_one.name]
        csv << ["Project 2", "ANC401I/000A/008A", area_two.name]
      end
    end

    after do
      # delete the CSV file after the test
      File.delete(csv_file)
    end

    it "imports projects from a CSV file" do
      expect { Rake::Task["projects:import"].invoke }.to output(/../).to_stdout
    end
  end

  describe "projects:delete_all", type: :rake do
    let(:task_name) { "projects:delete_all" }
    let(:storage_path) { Rails.root.join("storage") }

    before do
      # create some test projects
      create(:full_project)
    end

    after do
      # delete all projects after the test
      PafsCore::Project.delete_all
    end

    it "deletes all projects" do
      # run the task
      Rake::Task[task_name].invoke

      # check if all projects were deleted
      expect(PafsCore::Project.count).to eq(0)
    end

    it "deletes all project associated files" do
      # run the task
      Rake::Task[task_name].invoke

      # check if all associated files were deleted
      expect(Dir.glob("#{storage_path}/**/*").empty?).to be(true)
    end
  end
end
