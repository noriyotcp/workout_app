RSpec.feature "ListingExercises", type: :feature do
  given!(:user) { create(:user) }
  given!(:friend) { create(:user) }
  given!(:friendship) { Friendship.create(user: user, friend: friend) }
  given!(:exercise1) { create(:exercise, user_id: user.id) }
  given!(:exercise2) { create(:exercise, user_id: user.id) }
  given!(:exercise3) { create(:exercise, user_id: user.id, workout_date: Time.now.days_ago(7)) }

  background {
    login_as(user)
    visit "/"
    click_link "My Lounge"
  }


  scenario "shows user's workouts for last 7days" do
    within "tbody" do
      expect(page).to have_content exercise1.duration_in_min
      expect(page).to have_content exercise1.workout
      expect(page).to have_content exercise1.workout_date
      expect(page).to have_content exercise2.duration_in_min
      expect(page).to have_content exercise2.workout
      expect(page).to have_content exercise2.workout_date
    end
  end

  scenario "does not show user's workouts before 7 days ago" do
    within "tbody" do
      expect(page).not_to have_content exercise3.duration_in_min
      expect(page).not_to have_content exercise3.workout
      expect(page).not_to have_content exercise3.workout_date
    end
  end

  scenario "show a list of users friends" do
    expect(page).to have_content "My Friends"
    expect(page).to have_link friend.full_name
    expect(page).to have_link "Unfollow"
  end
end
