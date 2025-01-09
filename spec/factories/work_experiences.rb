FactoryBot.define do
  factory :work_experience do
    association :resume
    content { Faker::Lorem.paragraph }
  end
end
