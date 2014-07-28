FactoryGirl.define do

  sequence(:name) { |n| "name#{n}" }
  sequence(:literal) { |n| "literal#{n}" }

  factory :language do
    iso 'en'
    name
  end

  factory :app do
    name
    languages { [create(:language)] }
  end

  factory :text do
    literal
    accepted true
    app { create(:app) }
  end

  factory :translation do
    literal
    text { create(:text) }
    language { create(:language) }
  end

end
