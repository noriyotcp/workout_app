RSpec.describe FriendshipsController, type: :controller do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let!(:friendship) { Friendship.create(user: user, friend: friend) }

  before { sign_in user }

  describe "GET #show" do
    it "returns http success" do
      get :show, { id: friendship }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns status 302" do
      post :create, { friend_id: friend }
      expect(response).to redirect_to root_path
      expect(response).to have_http_status(302)
    end

    it "creates a new friend" do
        expect {
          post :create, { friend_id: friend }
        }.to change(user.friendships, :count).by(1)
      end

      it "redirects to the root" do
        post :create, { friend_id: friend }
        expect(response).to redirect_to root_path
      end
  end

  describe "GET #destroy" do
    it "destroys the requested friendship" do
      expect {
        delete :destroy, { id: friendship }
      }.to change(Friendship, :count).by(-1)
    end

    it "returns status 302" do
      get :destroy, { id: friendship }
      expect(response).to redirect_to user_exercises_path(user)
      expect(response).to have_http_status(302)
    end
  end
end
