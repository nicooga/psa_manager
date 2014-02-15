FactoryGirl.define do
  factory :installation do
    date    { Faker::Time.date }
    kit
    contact
    address
    user    { kit.user }
  end
end
