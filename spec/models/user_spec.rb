RSpec.describe User, type: :model do
  describe "ASSOCIATION" do
    it { is_expected.to have_many :exercises }
  end
end
