# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    target_date { Faker::Time.date }
    type        { [:DemoArrangement, :Demo].sample}
    notes       { Faker::Lorem.sentence }
    contact
    address     { contact.addresses.sample }
    user

    Activity::TYPES.each do |type|
      factory(type.underscore, class: type) { type type }
    end
  end
end
