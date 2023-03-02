# frozen_string_literal: true

require "csv"

# rubocop:disable Metrics/BlockLength
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

  desc "Change areas for a set of projects"
  task :change_areas, [:areas_file] => :environment do |_t, args|
    projects = CSV.read(Rails.root.join(args[:areas_file])).to_a
    projects.shift

    projects.each do |row|
      project_number = row[0]
      new_name = row[2]
      PafsCore::ChangeProjectAreaService.new(project_number).run(new_name)
    rescue StandardError => e
      puts "Error changing area for project #{project_number}: #{e}"
    end
  end
end
# rubocop:enable Metrics/BlockLength
