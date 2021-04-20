# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    name { 'Bill Tester' }
  end
end
