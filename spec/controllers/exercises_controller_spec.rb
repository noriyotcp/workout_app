# == Schema Information
#
# Table name: exercises
#
#  id              :integer          not null, primary key
#  duration_in_min :integer          not null
#  workout         :text             not null
#  workout_date    :date             not null
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

  describe "GET new" do
    before { get :new, { user_id: user } }
    it "assigns a new exercise as @exercise" do
      expect(assigns(:exercise)).to be_a_new(Exercise)
    end
  end

  describe "GET edit" do
    before { exercise }
    it "assigns the requested exercise as @exercise" do
      get :edit, { user_id: user, id: exercise }
      expect(assigns(:exercise)).to eq(exercise)
    end
  end


  describe "POST create" do
    describe "with valid params" do
      it "creates a new Exercise" do
        expect {
          post :create, { user_id: user, exercise: attributes_for(:exercise) }
        }.to change(Exercise, :count).by(1)
      end

      it "assigns a newly created exercise as @exercise" do
        post :create, { user_id: user, exercise: attributes_for(:exercise) }
        expect(assigns(:exercise)).to be_a(Exercise)
        expect(assigns(:exercise)).to be_persisted
      end

      it "redirects to the created exercise" do
        post :create, { user_id: user, exercise: attributes_for(:exercise) }
        expect(response).to redirect_to [user, Exercise.last]
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved exercise as @exercise" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, { user_id: user, exercise: attributes_for(:exercise, duration_in_min: nil) }
        expect(assigns(:exercise)).to be_a_new(Exercise)
        expect(assigns(:exercise)).not_to be_persisted
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, { user_id: user, exercise: attributes_for(:exercise, duration_in_min: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH update" do
    before { exercise }

    describe "with valid params" do
      let(:new_duration) { exercise.duration_in_min + 10 }
      it "updates the requested exercise" do
        patch :update, { id: exercise, user_id: user, exercise: attributes_for(:exercise, duration_in_min: new_duration) }
        exercise.reload
        expect(exercise.duration_in_min).to eq new_duration
      end

      it "assigns the exercise as @exercise" do
        patch :update, { id: exercise, user_id: user, exercise: attributes_for(:exercise, duration_in_min: new_duration) }
        expect(assigns(:exercise)).to be_a(Exercise)
        expect(assigns(:exercise)).to eq exercise
      end

      it "redirects to the updated exercise" do
        patch :update, { id: exercise, user_id: user, exercise: attributes_for(:exercise, duration_in_min: new_duration) }
        expect(response).to redirect_to [user, exercise]
      end
    end

    describe "with invalid params" do
      let!(:old_duration) { exercise.duration_in_min }

      it "does not update the requested exercise" do
        expect {
          patch :update, { id: exercise, user_id: user,
                          exercise: attributes_for(:exercise, duration_in_min: nil) }
        }.not_to change { exercise.duration_in_min }.from old_duration
        exercise.reload
        expect(exercise.duration_in_min).to eq old_duration
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        patch :update, { id: exercise, user_id: user,
                          exercise: attributes_for(:exercise, duration_in_min: nil) }
        expect(response).to render_template :edit
      end
    end
  end
end
