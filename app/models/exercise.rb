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

class Exercise < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :duration_in_min, presence: true, numericality: { only_integer: true }
  validates :workout, presence: true
  validates :workout_date, presence: true

  default_scope { where('workout_date > ?', 7.days.ago).order(workout_date: :desc) }
end
