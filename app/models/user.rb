# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, #:registerable, :rememberable
         :recoverable, :trackable, :validatable, :timeoutable

  has_many :user_areas
  has_many :areas, through: :user_areas

  def full_name
    "#{first_name} #{last_name}"
  end

  def primary_area
    user_areas.includes(:area).find_by(primary: true).area
  end

  def update_primary_area(area)
    user_areas.where(primary: true).update_all(primary: false)
    user_areas.find_by(area: area).update(primary: true)
  end
end
