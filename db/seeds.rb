# frozen_string_literal: true

def create_user(first_name, last_name, email, password, admin)
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    password: password,
    password_confirmation: password,
    admin: admin
  )
end

# rubocop:disable Rails/Output
def seed_users
  seeds = JSON.parse(Rails.root.join("db/seeds/users.json").read)
  users = seeds["users"]

  users.each do |user|

    if User.find_by(email: user["email"])
      puts "User already exists with email: #{user['email']}, skipping"

      next
    end

    puts "Creating seed user #{user['email']}"

    seed_user = create_user(user["first_name"],
                            user["last_name"],
                            user["email"],
                            user["password"],
                            user["admin"])

    user["areas"].each_with_index do |area, index|
      pafs_area = PafsCore::Area.find_by(name: area["name"], area_type: area["type"])
      seed_user.user_areas.find_or_create_by!(area_id: pafs_area.id, primary: index.zero?)
    end
  end
end
# rubocop:enable Rails/Output

# Only seed if not running in production or we specifically require it, eg. for Heroku
seed_users if !Rails.env.production? || ENV["ALLOW_SEED"]

PafsCore::ReferenceCounter.seed_counters
