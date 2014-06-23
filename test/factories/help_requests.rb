# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :help_request do
    nature { Faker::Company.bs }
    attempted { Faker::Lorem.paragraph }
    resolved_at nil
    user
  end
end
