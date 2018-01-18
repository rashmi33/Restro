FactoryGirl.define do
  factory :menu do
    name Faker::Food.dish
    menu_type 'Indian'
    price Faker::Number.decimal(5,2)
    association :restaurant, factory: :restaurant, strategy: :build
  end
end