# == Schema Information
#
# Table name: exercises
#
#  id              :integer          not null, primary key
#  duration_in_min :integer          not null
#  workout         :text             not null
#  workout_date    :date             not null
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
    sequence :duration_in_min do |n|
      (n + 1) * 10
    end
    sequence :workout do |n|
      "Workout#{n}"
    end
    workout_date Time.now
    association :user, strategy: :build
  end
end
