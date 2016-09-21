# frozen_string_literal: true
require "csv"
namespace :projects do
  desc "Load placeholders for existing projects"
  task import: :environment do
    success = []
    errors = []
    projects = CSV.read(Rails.root.join("tmp", "projects.csv"),
                        headers: true).to_a.uniq

    projects.each do |row|
      project_name = row[0]
      project_number = row[1]
      rma = row[2]

      if project_name.present? && project_number.present? && rma.present?
        # validate project_number
        # if project_number =~ /\A[A-Z]{2,3}\d{3}[A-Z]?\/\d{3}[A-Z]?\/\d{3,4}[A-Z]\z/
        if project_number =~ /\A(AC|AE|AN|NO|NW|SN|SO|SW|TH|TR|WX|YO)[A-Z]\d{3}[A-Z]\/\d{3}A\/\d{3}A\z/

          # check rma exists
          rma_area = PafsCore::Area.find_by(name: rma)
          if rma_area
            # create stub project
            # project = PafsCore::Project.create(name: project_name,
            #                                    reference_number: project_number,
            #                                    version: 1)
            success << row
            print "."
            # if project
            #   project.area_projects.create(area_id: rma_area.id, primary: true)
            #   print "."
            # else
            #   # report not being able to create project
            #   row[:error] = project.errors.full_messages.join(",")
            #   errors << row
            #   print "c"
            # end
          else
            # report rma doesn't exist
            row << "RMA not found: [#{rma}]"
            errors << row
            print "r"
          end
        else
          # report project_number doesn't match format
          row << "Project number format error: [#{project_number}]"
          errors << row
          print "F"
        end
      else
        row << "Empty entries: [#{project_name}] [#{project_number}] [#{rma}]"
        errors << row
        print "b"
      end
    end

    unless errors.empty?
      errors.unshift(["Project name", "Project number", "rma", "error"])
      CSV.open(Rails.root.join("tmp", "project_import_errors.csv"), "wb") do |csv|
        errors.each do |error|
          csv << error
        end
      end
    end
    unless success.empty?
      success.unshift(["Project name", "Project number", "rma"])
      CSV.open(Rails.root.join("tmp", "project_import_success.csv"), "wb") do |csv|
        success.each do |r|
          csv << r
        end
      end
    end
  end
end
