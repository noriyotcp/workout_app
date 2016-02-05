module SessionHelper
  def login_from_ui(email, password)
    visit "/"
    click_link "Log in"

    fill_in "Email", with: email
    fill_in "Password", with: password

    click_button "Log in"
  end
end