class Project < ActiveRecord::Base
  validates :reference_number, presence: true, uniqueness: true

  def to_param
    reference_number
  end
end
