# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#maintenance_banner_message" do
    let(:expected_message) do
      "PAFS will be unavailable from #{start_at} to #{end_at} while an essential upgrade is carried out. " \
        "Service will resume on #{resume_at}."
    end
    let(:start_at) { "noon on Thursday 25th June" }
    let(:end_at) { "Tuesday 30th June" }
    let(:resume_at) { "Wednesday 1st July" }

    it "uses the default maintenance dates" do
      expect(helper.maintenance_banner_message).to eq(expected_message)
    end

    context "with maintenance date environment variables" do
      around do |example|
        with_modified_env(
          "PAFS_MAINTENANCE_STARTS_AT" => start_at,
          "PAFS_MAINTENANCE_ENDS_AT" => end_at,
          "PAFS_SERVICE_RESUMES_AT" => resume_at
        ) { example.run }
      end

      let(:start_at) { "1pm on Monday 1st June" }
      let(:end_at) { "Friday 5th June" }
      let(:resume_at) { "Monday 8th June" }

      it "uses maintenance dates from the environment" do
        expect(helper.maintenance_banner_message).to eq(expected_message)
      end
    end
  end
end
