RSpec.shared_context "admin quequeo user" do
  let(:admin_quequeo_user) do
    user = create(:user, email: "admin@quequeo.com")
    user.roles << create(:role, name: "admin")
    user
  end
end
