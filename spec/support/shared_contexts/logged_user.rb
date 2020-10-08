RSpec.shared_context 'logged_user' do
  let!(:user) { create(:user) }

  before do
    @tokens = user.create_new_auth_token
  end
end
