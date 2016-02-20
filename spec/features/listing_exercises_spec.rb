RSpec.feature "ListingExercises", type: :feature do
  given(:user) { create(:user) }
  given(:exercise1) { create(:exercise, user_id: user.id) }
  given(:exercise2) { create(:exercise, user_id: user.id) }

  background {
    login_as(user)
    exercise1
    exercise2
  }

  scenario "shows user's workouts for last 7days" do
    visit "/"
    click_link "My Lounge"

    expect(page).to have_content exercise1.duration_in_min
    expect(page).to have_content exercise1.workout
    expect(page).to have_content exercise1.workout_date
    expect(page).to have_content exercise2.duration_in_min
    expect(page).to have_content exercise2.workout
    expect(page).to have_content exercise2.workout_date
  end
end
