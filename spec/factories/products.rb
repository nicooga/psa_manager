FactoryGirl.define do
  factory :product do
    bonificable_points       { rand(0.0..5).round 2 }
    name                     { Faker::Product.product }
    list_price_cents         { rand(500..4000) * 1000 }
    suggested_price_cents    { list_price_cents * 1.3 }
    expiration_time          { rand(1..5) * 6 }
    service_period           { expiration_time / 4 }
  end
end
