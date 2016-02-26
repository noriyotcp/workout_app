FactoryGirl.define do
  sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name) { Faker::Name.last_name }
  sequence(:email) { Faker::Internet.email }
end
