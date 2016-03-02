FactoryGirl.define do
  factory :project do
    reference_number { ProjectService.new.generate_reference_number }
    version 0
  end
end
