# frozen_string_literal: true

require "rails_helper"

RSpec.describe "areas", type: :rake do

  describe "areas:import_additional_areas", type: :rake do

    subject(:areas_task) { Rake::Task["areas:import_additional_areas"] }

    include_context "rake"

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

    include_context "rake"

    before { create(:rma_area, name: "foo") }

    it "runs without error" do
      expect { areas_task.invoke("RMA", "foo", "bar") }.not_to raise_error
    end
  end
end
