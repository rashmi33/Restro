FactoryGirl.define do
  factory :user do
    name Faker::Name.first_name
    address Faker::Address.street_address
    phone_no Faker::Number.number(17)
    association :restaurant, factory: :restaurant, strategy: :build
  end
end