# frozen_string_literal: true

require "csv"

namespace :areas do
  desc "Import All Areas"
  task import: :environment do
    areas_csv = Rails.root.join("lib/fixtures/areas/areas.csv")

    PafsCore::AreaImporter.new.full_import(areas_csv)
  end

  desc "Import Additional Areas"
  task :import_additional_areas, [:areas_file] => :environment do |_t, args|
    new_areas_csv_file = Rails.root.join("lib/fixtures/areas/#{args[:areas_file]}")

    PafsCore::AreaImporter.new.import_additional_areas(new_areas_csv_file)
  end

  desc "Rename an Area"
  task :rename_area, %i[area_type area_name new_name] => :environment do |_t, args|
    PafsCore::AreaRenameService.new(args[:area_type], args[:area_name]).run(args[:new_name])
  end
end
