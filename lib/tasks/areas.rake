# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

require "csv"
namespace :areas do
  desc "Import Areas"
  task import: :environment do
    areas_csv = Rails.root.join("lib/fixtures/areas.csv")

    PafsCore::AreaImporter.new.import(areas_csv)
  end

  desc "Import New Areas"
  task import_new_areas: :environment do
    new_areas_csv_folder = Rails.root.join("lib/fixtures/new_areas")

    PafsCore::AreaImporter.new.import_new_areas(new_areas_csv_folder)
  end
end
