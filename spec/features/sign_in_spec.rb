RSpec.feature "SignIn", type: :feature do
  feature "with valid credentials" do
    let(:user) { create(:user) }

    background do
      visit "/"
      click_link "Log in"

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"
    end
    scenario "Success to sign in" do
      expect(page).to have_content I18n.t 'devise.sessions.signed_in'
    end
  end

  feature "with invalid credentials" do
    let(:user) { create(:user) }

    background do
      visit "/"
      click_link "Log in"
    end

    feature "email is invalid" do
      scenario "Fail to sign in" do
        fill_in "Email", with: "john@example"
        fill_in "Password", with: user.password

        click_button "Log in"
        expect(page).to have_content I18n.t 'devise.failure.invalid',
        authentication_keys: 'email'
      end
    end

    feature "password is invalid" do
      scenario "Fail to sign in" do
        fill_in "Email", with: user.email
        fill_in "Password", with: "invalidpass"

        click_button "Log in"
        expect(page).to have_content I18n.t 'devise.failure.invalid',
        authentication_keys: 'email'
      end
    end
  end

  feature "the user does not exist" do
    background do
      visit "/"
      click_link "Log in"

      fill_in "Email", with: "john@doe.com"
      fill_in "Password", with: "password"

      click_button "Log in"
    end

    scenario 'Fail to sign in' do
      expect(page).to have_content I18n.t 'devise.failure.not_found_in_database',
      authentication_keys: 'email'
    end
  end
end
