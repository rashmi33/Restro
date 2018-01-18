FactoryGirl.define do
  factory :invoice do
    code 'A7878A'
    amount Faker::Number.decimal(5, 2)
    association :order, factory: :order, strategy: :build
  end
end