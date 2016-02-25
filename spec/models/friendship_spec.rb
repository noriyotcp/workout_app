RSpec.describe Friendship, type: :model do
  describe "ASSOCIATION" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:friend).class_name('User') }
  end

end
