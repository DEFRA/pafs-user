# frozen_string_literal: true

require "rails_helper"

RSpec.describe "areas", type: :rake do

  include_context "rake"

  describe "areas:import_additional_areas", type: :rake do

    subject(:areas_task) { Rake::Task["areas:import_additional_areas"] }

    let(:importer) { instance_double(PafsCore::AreaImporter) }

    before do
      allow(PafsCore::AreaImporter).to receive(:new).and_return(importer)
      allow(importer).to receive(:import_additional_areas)
    end

    it "runs without error" do
      expect { areas_task.invoke("foo.csv") }.not_to raise_error

      expect(importer).to have_received(:import_additional_areas)
    end
  end

  describe "areas:rename_area", type: :rake do

    subject(:areas_task) { Rake::Task["areas:rename_area"] }

    before { create(:rma_area, name: "foo") }

    it "runs without error" do
      expect { areas_task.invoke("RMA", "foo", "bar") }.not_to raise_error
    end
  end

  describe "areas:change_areas", type: :rake do

    subject(:areas_task) { Rake::Task["areas:change_areas"] }

    before do
      a1 = create(:rma_area, name: "Allerdale Borough Council")
      a2 = create(:rma_area, name: "Barrow-in-Furness Borough Council")
      a3 = create(:rma_area, name: "Copeland Borough Council")
      create(:rma_area, name: "Cumberland Council")
      create(:rma_area, name: "Westmorland and Furness Council")

      create(:project, reference_number: "NWC501E/000A/042A", areas: [a1])
      create(:project, reference_number: "NWC501E/000A/570A", areas: [a2])
      create(:project, reference_number: "NWC501E/000A/614A", areas: [a3])
    end

    it "runs without error" do
      expect { areas_task.invoke("spec/fixtures/rma_changes.csv") }.not_to raise_error
    end
  end
end
