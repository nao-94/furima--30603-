FactoryBot.define do
  factory :item do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    category_id { Random.rand(2..11) }
    condition_id { Random.rand(2..7) }
    postage_payer_id { Random.rand(2..3) }
    prefecture_id { Random.rand(2..48) }
    handing_time_id { Random.rand(2..4) }
    price { Random.rand(300..9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/test_image.png'), filename: 'test_image.png')
    end
  end
end
