RSpec.describe Exercise, type: :model do
  describe "ASSOCIATION" do
    it { is_expected.to belong_to :user }
  end

  describe "VALIDATION" do
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :duration_in_min }
    it { is_expected.to validate_numericality_of(:duration_in_min).only_integer }
    it { is_expected.to validate_presence_of :workout }
    it { is_expected.to validate_presence_of :workout_date }
  end

  describe "#default_scope" do
    let!(:exercise1) { create(:exercise, workout_date: Time.now.days_ago(7)) }
    let!(:exercise2) { create(:exercise, workout_date: Time.now.days_ago(6)) }
    let!(:exercise3) { create(:exercise, workout_date: Time.now.days_ago(5)) }

    it "orders exercises by workout_date: :desc over the last 7 days" do
      expect(Exercise.all).to eq [exercise3, exercise2]
    end
  end
end
