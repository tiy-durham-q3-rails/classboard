# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    teacher false

    factory :user_with_authorization do
      after(:create) do |user, evaluator|
        user.add_provider("provider" => "developer", "uid" => user.email)
      end
    end
  end
end
