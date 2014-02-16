# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    target_date { Faker::Time.date }
    type        { [:DemoArrangement, :Demo].sample}
    notes       { Faker::Lorem.sentence }
    contact
    address     { contact.addresses.sample }
    user

    (Activity::TYPES - ['ServiceArrangement']).each do |type|
      factory(type.underscore, class: type)
    end

    factory :service_arrangement, class: ServiceArrangement do
      installation
    end
  end
end
