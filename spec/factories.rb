FactoryGirl.define do

  sequence(:name) { |n| "name#{n}" }

  factory :language do
    iso 'en'
    name
  end

  factory :app do
    name
  end

end
