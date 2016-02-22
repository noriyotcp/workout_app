require 'rails_helper'

RSpec.feature "EditingExercise", type: :feature do
  given!(:exercise) { create(:exercise) }
  given!(:user) { exercise.user }
  given!(:old_duration) { exercise.duration_in_min }
  given!(:new_duration) { exercise.duration_in_min + 10 }

  before { login_as(user) }

  scenario "success to update an exercise" do
    visit "/"
    click_link "My Lounge"
    link = "a[href='/users/#{user.id}/exercises/#{exercise.id}/edit']"
    find(link).click

    fill_in "Duration", with: new_duration
    click_button "Update Exercise"
    expect(page).to have_content "Exercise has been updated"
    target = find(:xpath, "//div/div/div/div[2]/div[2]")
    targets = page.all("div.member>div.col-xs-8")

    # xpath
    expect(target).to have_content new_duration
    expect(target).not_to have_content old_duration
    # css
    expect(targets[0]).to have_content new_duration
    expect(targets[0]).not_to have_content old_duration
  end

end
