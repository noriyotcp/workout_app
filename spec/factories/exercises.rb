# == Schema Information
#
# Table name: exercises
#
#  id              :integer          not null, primary key
#  duration_in_min :integer
#  workout         :text
#  workout_date    :date
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_exercises_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :exercise do
    duration_in_min 1
    workout "MyText"
    workout_date "2016-02-08"
    user User.first
  end
end
