RSpec.describe Exercise, type: :model do
  describe "ASSOCIATION" do
    it { is_expected.to belong_to :user }
  end
  describe "VALIDATION" do
    it { is_expected.to validate_presence_of :user }
  end
end
