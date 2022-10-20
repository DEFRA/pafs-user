# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

class User < PafsCore::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, # :registerable, :rememberable
         :recoverable, :trackable, :timeoutable, # :validatable,
         :password_archivable, :session_limitable, :secure_validatable

  def active_for_authentication?
    !disabled?
  end

  def inactive_message
    "You must register for an account before using this service" if disabled?
  end
end
