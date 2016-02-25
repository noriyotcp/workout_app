RSpec.feature "UnfollowFriends", type: :feature do
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let(:friendship) { Friendship.create(user: user, friend: friend) }

  before {
    login_as user
    friendship
    visit "/"
    click_link "My Lounge"
  }

  scenario "success to unfollow" do

    expect(page).to have_content friend.full_name
    expect(page).to have_link "Unfollow"

    link = "a[href='/friendships/#{friendship.id}'][data-method='delete']"
    find(link).click

    expect(page).to have_content friend.full_name + " unfollowed"
  end
end
