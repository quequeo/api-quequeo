FactoryBot.define do
  factory :personal_information do
    association :resume
    content { Faker::Lorem.paragraph }
  end
end
