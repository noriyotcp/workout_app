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
end
