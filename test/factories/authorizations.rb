# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorization do
    provider "developer"
    uid { Faker::Internet.email }
  end
end
