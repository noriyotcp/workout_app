RSpec.feature "ListingMembers", type: :feature do
  # let(:user1) { create(:user) }
  # let(:user2) { create(:user) }
  let!(:users) { create_list(:user, 2) }

  scenario "shows a list of registered members" do
    visit "/"
    expect(page).to have_content "List of Members"
    expect(page).to have_content users.first.full_name
    expect(page).to have_content users.second.full_name
  end

  feature "When no members" do
    before { User.delete_all }

    scenario "shows 'There's no members'" do
      visit "/"
      expect(page).to have_content "List of Members"
      expect(page).to have_content "There's no members"
      expect(page).not_to have_content users.first.full_name
      expect(page).not_to have_content users.second.full_name
    end
  end
end
