RSpec.feature "SigningUsersUp", type: :feature do
  scenario "with valid credentials" do
    visit "/"
    click_link "Sign up"

    fill_in "Email", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Password Confirmation", with: "password"

    click_button "Sign up"
    expect(page).to have_content "Welcome! You have signed up successfully."
  end
end
