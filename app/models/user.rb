# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
class User < PafsCore::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, #:registerable, :rememberable
         :recoverable, :trackable, :validatable, :timeoutable
end
