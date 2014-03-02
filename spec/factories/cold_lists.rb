# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cold_list do
    user nil
    responsible nil
    notes "MyText"
  end
end
