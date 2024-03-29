# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

require "csv"

# rubocop:disable Metrics/BlockLength
namespace :users do
  desc "User invitation"
  task invite: :environment do
    errors = []
    CSV.foreach(Rails.root.join("tmp/users.csv", headers: true)) do |row|
      area = PafsCore::Area.find_by(name: row["area"])
      if area
        user = User.invite!({ email: row["email"],
                              first_name: row["first_name"],
                              last_name: row["last_name"] }) do |u|
          u.skip_invitation = true
        end

        PafsCore::UserArea.create(area: area, user: user, primary: true)
        AccountRequestMailer.account_created_email(user).deliver_now
        user.invitation_sent_at = Time.now.utc

        puts "#{user.email} invited"
      else
        row["error"] = "No area found"
        errors << row
        puts "#{row['email']} not invited"
      end
    end

    unless errors.empty?
      CSV.open(Rails.root.join("tmp/user_creation_errors.csv", "wb", headers: true)) do |csv|
        errors.each do |error|
          csv << error
        end
      end
    end
  end
  desc "Clean up stale invitations and account requests"
  task clean: :environment do
    PafsCore::AccountRequestCleanupJob.new.perform
  end
end
# rubocop:enable Metrics/BlockLength
