FactoryBot.define do
  factory :resume do
    title { Faker::Job.title }
    style { Resume::STYLES.keys.sample }
    association :user
  end
end
