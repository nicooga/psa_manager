# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone_number do
    kind   { PhoneNumber::KINDS.sample }
    number { Faker::PhoneNumber.phone_number }
  end
end
