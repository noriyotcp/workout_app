RSpec.feature "CreatingExercise", type: :feature do
  given(:user) { create(:user) }

  before { login_as(user) }

  scenario "success to create an exercise" do
    visit "/"
    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_content "Back"

    fill_in "Duration", with: 70
    fill_in "Workout Details", with: "Weight lifting"
    fill_in "Activity date", with: "2015-08-07"
    click_button "Create Exercise"
    expect(page).to have_content "Exercise has been created"

    exercise = Exercise.last

    expect(current_path).to eq user_exercise_path(user, exercise)
  end

  scenario "fail to create an exercise" do
    visit "/"
    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_content "Back"

    fill_in "Duration", with: nil
    fill_in "Workout Details", with: ""
    fill_in "Activity date", with: ""
    click_button "Create Exercise"
    expect(page).to have_content "Exercise has not been created"
    expect(page).to have_content "Duration in min can't be blank"
    expect(page).to have_content "Duration in min is not a number"
    expect(page).to have_content "Workout can't be blank"
    expect(page).to have_content "Workout date can't be blank"
  end
end
