# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, #:registerable, :rememberable
         :recoverable, :trackable, :validatable, :timeoutable

  def full_name
    "#{first_name} #{last_name}"
  end
end
