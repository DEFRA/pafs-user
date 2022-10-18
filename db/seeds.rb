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

def seed_users
  seeds = JSON.parse(Rails.root.join("db/seeds/users.json").read)
  users = seeds["users"]

  users.each do |user|
    seed_user = create_user(user["first_name"],
                            user["last_name"],
                            user["email"],
                            user["password"],
                            user["admin"])
    user["areas"].each_with_index do |area_name, index|
      default_parent = PafsCore::Area.find_or_create_by(name: "a_parent", area_type: "Country")
      default_parent.save!
      area = PafsCore::Area.find_or_create_by(name: area_name, area_type: "EA Area", parent: default_parent)
      area.save!
      seed_user.user_areas.find_or_create_by!(area_id: area.id, primary: index.zero?)
    end
  end
end

# Only seed if not running in production or we specifically require it, eg. for Heroku
seed_users if !Rails.env.production? || ENV["WCR_ALLOW_SEED"]

PafsCore::ReferenceCounter.seed_counters
