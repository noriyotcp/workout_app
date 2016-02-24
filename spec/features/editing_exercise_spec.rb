require 'rails_helper'

RSpec.feature "EditingExercise", type: :feature do
  given!(:exercise) { create(:exercise) }
  given!(:user) { exercise.user }
  given!(:old_duration) { exercise.duration_in_min }
  given!(:new_duration) { exercise.duration_in_min + 10 }

  before {
    login_as(user)
    visit "/"
    click_link "My Lounge"
    link = "a[href='/users/#{user.id}/exercises/#{exercise.id}/edit']"
    find(link).click
  }

  scenario "success to update an exercise" do
    fill_in "Duration", with: new_duration
    click_button "Update Exercise"
    expect(page).to have_content "Exercise has been updated"
    target = find(:xpath, "//div[contains(@id, 'duration_in_min')]")
    targets = page.all("div.member>div.col-xs-8")

    # xpath
    expect(target).to have_content new_duration
    expect(target).not_to have_content old_duration
    # css
    expect(targets[0]).to have_content new_duration
    expect(targets[0]).not_to have_content old_duration
    # have_css matcher
    expect(page).to have_css("#duration_in_min", text: new_duration)
    expect(page).not_to have_css("#duration_in_min", text: old_duration)
  end

  scenario "fail to update an exercise" do
    fill_in "Duration", with: nil
    click_button "Update Exercise"
    expect(page).to have_content "Exercise has not been updated"
  end

  feature "When update Activity date before 7 days ago" do
    before {
      fill_in "exercise[workout_date]", with: Time.now.days_ago(7)
      click_button "Update Exercise"
    }

    scenario "Index page has not the exercise" do
      click_link "My Lounge"
      expect(page).not_to have_content exercise.workout_date
    end
  end

end
