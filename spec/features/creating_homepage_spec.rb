RSpec.feature "Creating Home Page", type: :feature do
  feature "when the user visits home page" do
    before { visit "/" }
    scenario "the user can see the links" do
      expect(page).to have_link "Athletes Den"
      expect(page).to have_link "Home"
      expect(page).to have_content "Workout Lounge!"
    end
  end
end
