# frozen_string_literal: true

require "csv"

namespace :projects do
  desc "Identify projects with records outside of project start and end dates"
  task validate_date_ranges: :environment do
    validator = ProjectDateValidator.new
    validator.run
  end
end

# Service class to validate project date ranges
# rubocop:disable Metrics/ClassLength
class ProjectDateValidator
  def run
    puts "Identifying projects with records outside their date ranges..."
    puts "=" * 80

    invalid_projects = []
    projects_checked = 0

    PafsCore::Project.find_each do |project|
      projects_checked += 1
      issues = validate_project(project)

      invalid_projects << build_project_info(project, issues) if issues.any?

      print "." if (projects_checked % 100).zero?
    end

    report_results(projects_checked, invalid_projects)
  end

  private

  def validate_project(project)
    issues = []
    project_end_year = project.project_end_financial_year

    if project_end_year.blank?
      issues << "No project end financial year defined"
    else
      issues.concat(validate_date_ranges(project, project_end_year))
    end

    issues
  end

  def validate_date_ranges(project, project_end_year)
    issues = []
    earliest_years = []

    # Validate funding values
    funding_issues, earliest_funding = validate_funding_values(project, project_end_year)
    issues.concat(funding_issues)
    earliest_years << earliest_funding if earliest_funding

    # Validate flood protection outcomes
    flood_issues, earliest_flood = validate_flood_outcomes(project, project_end_year)
    issues.concat(flood_issues)
    earliest_years << earliest_flood if earliest_flood

    # Validate flood protection 2040 outcomes
    flood_two_thousand_forty_issues, earliest_two_thousand_forty = validate_flood_2040_outcomes(
      project, project_end_year
    )
    issues.concat(flood_two_thousand_forty_issues)
    earliest_years << earliest_two_thousand_forty if earliest_two_thousand_forty

    # Validate coastal erosion outcomes
    coastal_issues, earliest_coastal = validate_coastal_outcomes(project, project_end_year)
    issues.concat(coastal_issues)
    earliest_years << earliest_coastal if earliest_coastal

    # Check for records before project start
    project_start_year = earliest_years.min
    issues.concat(validate_records_before_start(project, project_start_year)) if project_start_year

    issues
  end

  def validate_funding_values(project, project_end_year)
    issues = []
    return [issues, nil] unless project.funding_values.any?

    earliest_year = project.funding_values.minimum(:financial_year)
    latest_year = project.funding_values.maximum(:financial_year)

    if latest_year && latest_year > project_end_year
      out_of_range = project.funding_values
                            .where("financial_year > ?", project_end_year)
                            .select(&:any_positive_values?)
      if out_of_range.any?
        issues << "#{out_of_range.count} funding value(s) with data after project end year #{project_end_year}"
      end
    end

    [issues, earliest_year]
  end

  def validate_flood_outcomes(project, project_end_year)
    issues = []
    return [issues, nil] unless project.flood_protection_outcomes.any?

    earliest_year = project.flood_protection_outcomes.minimum(:financial_year)
    latest_year = project.flood_protection_outcomes.maximum(:financial_year)

    if latest_year && latest_year > project_end_year
      out_of_range = project.flood_protection_outcomes
                            .where("financial_year > ?", project_end_year)
                            .select(&:any_positive_values?)
      if out_of_range.any?
        msg = "#{out_of_range.count} flood protection outcome(s) with data "
        msg += "after project end year #{project_end_year}"
        issues << msg
      end
    end

    [issues, earliest_year]
  end

  def validate_flood_2040_outcomes(project, project_end_year)
    issues = []
    return [issues, nil] unless project.flood_protection2040_outcomes.any?

    earliest_year = project.flood_protection2040_outcomes.minimum(:financial_year)
    latest_year = project.flood_protection2040_outcomes.maximum(:financial_year)

    if latest_year && latest_year > project_end_year
      out_of_range = project.flood_protection2040_outcomes
                            .where("financial_year > ?", project_end_year)
                            .select(&:any_positive_values?)
      if out_of_range.any?
        msg = "#{out_of_range.count} flood protection 2040 outcome(s) with data "
        msg += "after project end year #{project_end_year}"
        issues << msg
      end
    end

    [issues, earliest_year]
  end

  def validate_coastal_outcomes(project, project_end_year)
    issues = []
    return [issues, nil] unless project.coastal_erosion_protection_outcomes.any?

    earliest_year = project.coastal_erosion_protection_outcomes.minimum(:financial_year)
    latest_year = project.coastal_erosion_protection_outcomes.maximum(:financial_year)

    if latest_year && latest_year > project_end_year
      out_of_range = project.coastal_erosion_protection_outcomes
                            .where("financial_year > ?", project_end_year)
                            .select(&:any_positive_values?)
      if out_of_range.any?
        msg = "#{out_of_range.count} coastal erosion outcome(s) with data "
        msg += "after project end year #{project_end_year}"
        issues << msg
      end
    end

    [issues, earliest_year]
  end

  def validate_records_before_start(project, start_year)
    issues = []

    check_early_records(project.funding_values, "funding value", start_year, issues)
    check_early_records(project.flood_protection_outcomes, "flood protection outcome", start_year, issues)
    check_early_records(project.flood_protection2040_outcomes, "flood protection 2040 outcome", start_year, issues)
    check_early_records(project.coastal_erosion_protection_outcomes, "coastal erosion outcome", start_year, issues)

    issues
  end

  def check_early_records(relation, record_type, start_year, issues)
    early_records = relation.where(financial_year: ...start_year)
                            .select(&:any_positive_values?)
    return unless early_records.any?

    issues << "#{early_records.count} #{record_type}(s) with data before earliest year #{start_year}"
  end

  def build_project_info(project, issues)
    {
      project: project,
      reference_number: project.reference_number,
      name: project.name,
      status: project.status,
      project_end_year: project.project_end_financial_year,
      issues: issues
    }
  end

  def report_results(projects_checked, invalid_projects)
    puts "\n\nValidation Complete"
    puts "=" * 80
    puts "Total projects checked: #{projects_checked}"
    puts "Projects with date range issues: #{invalid_projects.count}"

    return puts "\nNo projects found with records outside their date ranges." if invalid_projects.empty?

    print_detailed_report(invalid_projects)
    export_to_csv(invalid_projects)
    print_summary_by_issue_type(invalid_projects)
  end

  def print_detailed_report(invalid_projects)
    puts "\nDetailed Issues:"
    puts "-" * 80

    invalid_projects.each_with_index do |project_info, index|
      puts "\n#{index + 1}. Project: #{project_info[:reference_number]} - #{project_info[:name]}"
      puts "   Status: #{project_info[:status]}"
      puts "   Project End Year: #{project_info[:project_end_year] || 'Not set'}"
      puts "   Issues:"
      project_info[:issues].each do |issue|
        puts "     - #{issue}"
      end
    end
  end

  def export_to_csv(invalid_projects)
    timestamp = Time.current.strftime("%Y%m%d_%H%M%S")
    csv_filename = Rails.root.join("tmp", "project_date_validation_#{timestamp}.csv")

    CSV.open(csv_filename, "wb") do |csv|
      csv << ["Reference Number", "Project Name", "Status", "Project End Year", "Issues"]

      invalid_projects.each do |project_info|
        csv << [
          project_info[:reference_number],
          project_info[:name],
          project_info[:status],
          project_info[:project_end_year] || "Not set",
          project_info[:issues].join("; ")
        ]
      end
    end

    puts "\n#{'=' * 80}"
    puts "Results exported to: #{csv_filename}"
  end

  def print_summary_by_issue_type(invalid_projects)
    puts "\nSummary by Issue Type:"
    puts "-" * 40

    issue_counts = count_issues_by_type(invalid_projects)

    issue_counts.each do |issue_type, count|
      puts "  #{issue_type}: #{count} project(s)"
    end
  end

  def count_issues_by_type(invalid_projects)
    issue_counts = Hash.new(0)

    invalid_projects.each do |project_info|
      project_info[:issues].each do |issue|
        category = categorize_issue(issue)
        issue_counts[category] += 1 if category
      end
    end

    issue_counts
  end

  def categorize_issue(issue)
    case issue
    when /funding value.*with data/
      "Funding values with data outside range"
    when /flood protection outcome.*with data/
      "Flood protection outcomes with data outside range"
    when /flood protection 2040.*with data/
      "Flood protection 2040 outcomes with data outside range"
    when /coastal erosion.*with data/
      "Coastal erosion outcomes with data outside range"
    when /No project end/
      "No project end year defined"
    end
  end
end
# rubocop:enable Metrics/ClassLength
