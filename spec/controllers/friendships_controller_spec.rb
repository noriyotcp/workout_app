RSpec.describe FriendshipsController, type: :controller do
  let(:john) { create(:user) }
  let(:peter) { create(:user) }
  let(:friendships) { Friendship.create(user: john, friend: peter) }

  describe "GET #show" do
    before { sign_in(john) }

    it "returns http success" do
      get :show, { id: friendships }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    before { sign_in(john) }

    it "returns status 302" do
      post :create, { friend_id: peter }
      expect(response).to have_http_status(302)
    end

    it "creates a new friend" do
        expect {
          post :create, { friend_id: peter }
        }.to change(john.friendships, :count).by(1)
      end

      it "redirects to the root" do
        post :create, { friend_id: peter }
        expect(response).to redirect_to root_path
      end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
