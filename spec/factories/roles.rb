FactoryBot.define do
  factory :role do
    name { Faker::Job.unique.position }
  end
end
