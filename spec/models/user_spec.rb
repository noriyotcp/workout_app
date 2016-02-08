RSpec.describe User, type: :model do
  describe "ASSOCIATION" do
    it { is_expected.to have_many :exercises }
  end

  describe "VALIDATION" do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
  end
end
