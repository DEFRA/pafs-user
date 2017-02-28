# frozen_string_literal: true
FactoryGirl.define do
  factory :account_request, class: PafsCore::AccountRequest do
    first_name "Big"
    last_name "Nev"
    email "neville.southall@example.com"
    organisation "Everton FC"
    job_title "Pie Eater"
    telephone_number "01234567890"
  end
end
