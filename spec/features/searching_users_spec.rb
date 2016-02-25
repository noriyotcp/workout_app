RSpec.feature "SearchingUsers", type: :feature do
  let!(:john) { create(:user, first_name: "John") }
  let!(:sara) { create(:user, first_name: "Sara") }

  background {
    visit "/"
    fill_in "search_name", with: "John"
    click_button "Search"
  }

  scenario "with existing name returns all those users" do
    expect(page).to have_content john.full_name
    expect(current_path).to eq "/dashboard/search"
  end
end
