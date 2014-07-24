FactoryGirl.define do

  factory :language do
    iso 'en'
    sequence(:name) { |n| "name{n}" }
  end

end
