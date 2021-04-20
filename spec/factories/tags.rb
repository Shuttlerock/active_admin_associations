# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Tag#{n}" }
  end
end
