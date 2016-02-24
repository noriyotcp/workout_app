RSpec.feature "SignUp", type: :feature do
  feature "with valid credentials" do
    background do
      visit "/"
      click_link "Sign up"

      fill_in "First name", with: "John"
      fill_in "Last name", with: "Doe"
      fill_in "Email", with: "john@example.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"

      click_button "Sign up"
    end

    scenario "Success to sign up" do
      expect(page).to have_content I18n.t 'devise.registrations.signed_up'
    end
  end

  feature "with invalid credentials" do
    background do
      visit "/"
      click_link "Sign up"
    end

    feature "email is invalid" do
      background do
        fill_in "First name", with: "John"
        fill_in "Last name", with: "Doe"
        fill_in "Email", with: "john@example"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"

        click_button "Sign up"
      end

      scenario "Fail to sign up" do
        expect(page).to have_content "Email is invalid"
      end
    end

    feature "names are blank" do
      background do
        fill_in "First name", with: ""
        fill_in "Last name", with: ""
        fill_in "Email", with: "john@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"

        click_button "Sign up"
      end

      scenario "Fail to sign up" do
        expect(page).to have_content "First name can't be blank"
        expect(page).to have_content "Last name can't be blank"
      end
    end
  end
end
