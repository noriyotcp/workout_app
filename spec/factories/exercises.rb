FactoryGirl.define do
  factory :exercise do
    duration_in_min 1
    workout "MyText"
    workout_date "2016-02-08"
    user User.first
  end
end
