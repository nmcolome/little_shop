FactoryGirl.define do

  factory :category do
    name

    factory :category_with_items do
      transient do
        item_count 5
      end

      after(:create) do |category, evaluator|
        create_list(:item, evaluator.items_count, category: category)
      end
    end
  end

  sequence :name do |n|
    "category_#{n}"
  end

  factory :item do
    title
    description 'Made in the Universe Space Area'
    price 100.00
    image
    status 'Active'
    categories
  end

  sequence :title do |n|
    "item_#{n}"
  end

  factory :user do
    role 0
    username
    email 'meatball_lover@puppy'
    password_digest 'meatball'
    address_line '2020 Lawrence st'
    first_name 'Zuzu'
    last_name 'Thomas'
    state 'CO'
    city 'Denver'
    zipcode 80205

    factory :user_with_orders do
      transient do
        orders_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:order, evaluator.orders_count, user: user)
      end
    end
  end

  sequence :username do |n|
    "user_#{n}"
  end

  factory :order do
    status 'Paid'
    item 3
    date_time
  end
end
