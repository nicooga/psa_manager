# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    state    { Address::STATES.sample }
    city     { Faker::Address.city }
    street   { Faker::Address.street_name }
    number   { rand 1..5000 }
    zip_code { Faker::AddressUS.zip_code }
    notes    { Faker::Lorem.sentence }

    after(:create) do |a|
      create_list :phone_number, 2, address: a
    end
  end
end
