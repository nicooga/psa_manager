require 'database_cleaner'
include ActionView::Helpers::TextHelper

DatabaseCleaner.clean_with :truncation

def create_resource(klass = nil, quantity)
  puts "Creating " + pluralize(quantity, klass.model_name.element)
  klass.create!(Array.new(quantity) { |i| yield(i) })
end

def build_resource(klass = nil, quantity)
  Array.new(quantity) { |i| klass.new yield(i) }
end

@users = create_resource(User, 1) do
  { email:    '2112.oga@gmail.com',
    provider: :google_oautH2,
    uid:      115826116306883610883 }
end

BIRTHDAY_DATES = ((Date.today - 80.years)..(Date.today - 20.years)).lazy.to_a

@contacts = create_resource(Contact, 50) do
  first_name, last_name = Faker::Name.first_name, Faker::Name.last_name
  {
    first_name:    first_name,
    last_name:     last_name,
    email:         Faker::Internet.email([first_name, last_name].join('_')),
    birthday:      BIRTHDAY_DATES.sample,
    notes:         Faker::Lorem.sentence,
    user:          @users.first,

    phone_numbers: build_resource(PhoneNumber, rand(1..2)) do
      { number: Faker::PhoneNumber.phone_number,
        kind:   PhoneNumber::KINDS.sample }
    end,

    addresses:     build_resource(Address, rand(1..2)) do
      {
        state:         Address::STATES.sample,
        city:          Faker::Address.city,
        street:        Faker::Address.street_name,
        number:        rand(1..5000),
        zip_code:      Faker::Address.zip_code,
        phone_numbers: build_resource(PhoneNumber, rand(1..2)) do
          { number: Faker::PhoneNumber.phone_number,
            kind:   PhoneNumber::KINDS.sample }
        end
      }
    end
  }
end
