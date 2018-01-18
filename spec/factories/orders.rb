FactoryGirl.define do
  factory :order do
    code 'A7878A'
    food_details_with_quantity Faker::Food.description
    association :menu, factory: :menu, strategy: :build
    association :user, factory: :user, strategy: :build
  end
end