RSpec.feature "ShowingFriendWorkout", type: :feature do
  given!(:user) { create(:user) }
  given!(:friend) { create(:user) }
  given!(:friendship) { Friendship.create(user: user, friend: friend) }
  given!(:exercise1) { create(:exercise, user_id: friend.id) }
  given!(:exercise2) { create(:exercise, user_id: friend.id) }
  given!(:exercise3) { create(:exercise, user_id: friend.id, workout_date: Time.now.days_ago(7)) }
  subject { page }

  background {
    login_as(user)
    visit "/"
    click_link "My Lounge"
    click_link friend.full_name
  }

  it { is_expected.to have_css("div#chart") }
  it { is_expected.to have_content(friend.full_name + "'s Exercise") }

  scenario "shows friend's workout for last 7 days" do
    subject { page }
    within "tbody" do
      is_expected.to have_content exercise1.duration_in_min
      is_expected.to have_content exercise1.workout
      is_expected.to have_content exercise1.workout_date
      is_expected.to have_content exercise2.duration_in_min
      is_expected.to have_content exercise2.workout
      is_expected.to have_content exercise2.workout_date
    end
  end

  scenario "does not show user's workouts before 7 days ago" do
    subject { page }
    within "tbody" do
      is_expected.not_to have_content exercise3.duration_in_min
      is_expected.not_to have_content exercise3.workout
      is_expected.not_to have_content exercise3.workout_date
    end
  end

end
