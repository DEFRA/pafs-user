# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
require "csv"
namespace :areas do
  desc "Import Areas"
  task import: :environment do
    areas_csv = Rails.root.join("lib/fixtures/areas.csv")

    PafsCore::AreaImporter.new.import(areas_csv)
  end
end
