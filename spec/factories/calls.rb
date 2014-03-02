# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :call do
    cold_list nil
    phone_number nil
    notes "MyText"
    status "MyString"
  end
end
