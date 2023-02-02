FactoryBot.define do
  factory :comment do
    text  {Faker::Lorem.sentence}
    
    association :drink
    association :user
  end
end
