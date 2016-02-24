class Project < ActiveRecord::Base
  validates :reference_number, presence: true, uniqueness: true
end
