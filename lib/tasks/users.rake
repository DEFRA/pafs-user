# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
require "csv"
namespace :users do
  desc "User invitation"
  task invite: :environment do
    errors = []
    CSV.foreach("#{Rails.root}/tmp/users.csv", headers: true) do |row|
      area = PafsCore::Area.find_by_name(row["area"])
      if area
        user = User.invite!({email: row["email"],
                             first_name: row["first_name"],
                             last_name: row["last_name"]})

        UserArea.create(area: area, user: user, primary: true)
        puts "#{user.email} invited"
      else
        row["error"] = "No area found"
        errors << row
        puts "#{row['email']} not invited"
      end
    end

    if !errors.empty?
      CSV.open("#{Rails.root}/tmp/user_creation_errors.csv", "wb", headers: true) do |csv|
        errors.each do |error|
          csv << error
        end
      end
    end
  end
end
