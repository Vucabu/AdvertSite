FactoryGirl.define do
  factory :user do
    name     "Vucabu"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :advert do
    content "Lorem ipsum"
    user
  end
end