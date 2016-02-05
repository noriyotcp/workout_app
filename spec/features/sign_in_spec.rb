RSpec.feature "SignIn", type: :feature do
  feature "with valid credentials" do
    let(:user) { create(:user) }

    scenario "Success to sign in" do
      login_from_ui(user.email, user.password)
      expect(page).to have_content I18n.t 'devise.sessions.signed_in'
      expect(page).to have_content "Signed in as #{user.email}"
    end
  end

  feature "with invalid credentials" do
    let(:user) { create(:user) }

    feature "email is invalid" do
      scenario "Fail to sign in" do
        login_from_ui("john@example", user.password)
        expect(page).to have_content I18n.t 'devise.failure.invalid',
        authentication_keys: 'email'
      end
    end

    feature "password is invalid" do
      scenario "Fail to sign in" do
        login_from_ui(user.email, "invalidpass")
        expect(page).to have_content I18n.t 'devise.failure.invalid',
        authentication_keys: 'email'
      end
    end
  end

  feature "the user does not exist" do
    scenario 'Fail to sign in' do
      login_from_ui("john@doe.com", "password")
      expect(page).to have_content I18n.t 'devise.failure.not_found_in_database',
      authentication_keys: 'email'
    end
  end
end
