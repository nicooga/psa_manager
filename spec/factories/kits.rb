FactoryGirl.define do
  factory :kit do
    serial_number    { SecureRandom.hex }
    acquisition_date { Faker::Time.date }
    product
    user
  end
end
