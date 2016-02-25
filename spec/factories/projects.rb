FactoryGirl.define do
  factory :project do
    reference_number { ProjectService.generate_reference_number }
  end
end
