require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:john) { create(:user) }
  let(:peter) { create(:user) }

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    before { sign_in(john) }

    it "returns status 302" do
      post :create, { friend_id: peter }
      expect(response).to have_http_status(302)
    end

    it "creates a new Exercise" do
        expect {
          post :create, { friend_id: peter }
        }.to change(john.friendships, :count).by(1)
      end

      it "redirects to the created exercise" do
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
