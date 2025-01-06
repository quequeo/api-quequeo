FactoryBot.define do
  factory :resume do
    title { "MyString" }
    style { Resume::STYLES.keys.sample }
    association :user
  end
end
