class Project < ActiveRecord::Base
  validates :reference_number, presence: true, uniqueness: { scope: :version }
  validates :reference_number, format: { with: /\AP[A-F0-9]{6}\z/, message: 'has an invalid format' }
  validates :version, presence: true

  def to_param
    reference_number
  end
end
