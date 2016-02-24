RSpec.feature "DeletingExercise", type: :feature do
  given!(:exercise) { create(:exercise) }
  given!(:user) { exercise.user }

  before {
    login_as(user)
    visit "/"
    click_link "My Lounge"
  }

  scenario "success to delete an exercise" do
    # click_link "Destroy"
    link = "//a[contains(@href, '/users/#{user.id}/exercises/#{exercise.id}') and .//text()='Destroy']"
    find(:xpath, link).click
    expect(page).to have_content "Exercise has been deleted"
  end

end
