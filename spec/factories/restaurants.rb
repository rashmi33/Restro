FactoryGirl.define do
  factory :restaurant do
    name Faker::Name.first_name
    address Faker::Address.street_address
    city Faker::Address.city
    phone_no Faker::Number.number(17)
    rating Faker::Number.number(1)
    is_veg 1
    has_bar 0
  end
end