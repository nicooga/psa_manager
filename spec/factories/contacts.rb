# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact, aliases: [:source] do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email([first_name, last_name].join(' ')) }
    birthday   { Faker::Time.date }
    notes      { Faker::Lorem.sentence }
    user

    after(:create) do |c|
      create_list :address, 2, contact: c
      create_list :phone_number, 2, contact: c
    end
  end
end
