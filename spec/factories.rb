FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@gmail.com" }
    password "password"
  end

  factory :post do
    factory :valid_post do
      title Faker::Commerce.product_name
      content Faker::Lorem.paragraph

      factory :published_post do
        is_published true
      end
    end

    factory :invalid_post do
      title nil
      content Faker::Lorem.paragraph
    end
  end
end
