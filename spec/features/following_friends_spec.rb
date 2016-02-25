RSpec.feature "FollowingFriends", type: :feature do
  let!(:john) { create(:user, first_name: "John") }
  let!(:peter) { create(:user, first_name: "Peter") }

  before { login_as john }

  scenario "if signed in succeeds" do
    visit "/"

    expect(page).to have_content john.full_name
    expect(page).to have_content peter.full_name
    expect(page).not_to have_link("Follow", href: "/friendships?friend_id=#{john.id}")

    link = "a[href='/friendships?friend_id=#{peter.id}']"
    find(link).click

    expect(page).not_to have_link("Follow", href: "/friendships?friend_id=#{peter.id}")
  end
end
