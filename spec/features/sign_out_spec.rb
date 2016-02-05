RSpec.feature "SignOut", type: :feature do
  feature "successful sign out" do
    let(:user) { create(:user) }

    background do
      login_as user
      visit "/"
      click_link "Log out"
    end

    scenario "Success to sign out" do
      expect(page).to have_content I18n.t 'devise.sessions.signed_out'
      expect(page).not_to have_content "Log out"
      expect(page).not_to have_content "Signed in as #{user.email}"
    end
  end
end
