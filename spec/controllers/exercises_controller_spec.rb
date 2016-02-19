# == Schema Information
#
# Table name: exercises
#
#  id              :integer          not null, primary key
#  duration_in_min :integer
#  workout         :text
#  workout_date    :date
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_exercises_on_user_id  (user_id)
#

RSpec.describe ExercisesController, type: :controller do
  let(:user) { create(:user) }
  let(:exercise) { create(:exercise, user: user) }
  let(:exercises) { create_list(:exercise, 5, user: user) }
  subject { response }

  before {
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  }

  describe "When the user sign in" do
    subject { @controller }
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end
  end

  describe "GET index" do
    before { get :index, user_id: user }

    it { is_expected.to be_success }

    it "should assigns @exercises" do
      expect(assigns(:exercises)).to eq exercises
    end

    it { is_expected.to render_template "index" }
  end

  describe "GET show" do
    before {
      exercise
      get :show, { user_id: user, id: exercise }
    }

    it { is_expected.to be_success }

    it "should assigns @exercise" do
      expect(assigns(:exercise)).to eq exercise
    end

    it { is_expected.to render_template "show" }

  end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Todo" do
  #       expect {
  #         post :create, {:todo => valid_attributes}, valid_session
  #       }.to change(Todo, :count).by(1)
  #     end

  #     it "assigns a newly created todo as @todo" do
  #       post :create, {:todo => valid_attributes}, valid_session
  #       assigns(:todo).should be_a(Todo)
  #       assigns(:todo).should be_persisted
  #     end

  #     it "redirects to the created todo" do
  #       post :create, {:todo => valid_attributes}, valid_session
  #       response.should redirect_to(Todo.last)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved todo as @todo" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Todo.any_instance.stub(:save).and_return(false)
  #       post :create, {:todo => { "title" => "invalid value" }}, valid_session
  #       assigns(:todo).should be_a_new(Todo)
  #     end

  #     it "re-renders the 'new' template" do
  #       # Trigger the behavior that occurs when invalid params are submitted
  #       Todo.any_instance.stub(:save).and_return(false)
  #       post :create, {:todo => { "title" => "invalid value" }}, valid_session
  #       response.should render_template("new")
  #     end
  #   end
  # end

end
