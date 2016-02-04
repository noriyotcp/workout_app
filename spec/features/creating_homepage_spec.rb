RSpec.feature "Creating Home Page", type: :feature do
  scenario "visit home page" do
    visit "/"

    expect(page).to have_link "Athletes Den"
    expect(page).to have_link "Home"
    expect(page).to have_content "Workout Lounge"
  end
end
