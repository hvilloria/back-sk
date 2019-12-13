RSpec.shared_context 'logged_user' do
  let!(:user) { create(:user) }

  before do
    sign_in user
    request.headers.merge!(user.create_new_auth_token) if sign_in(user)
  end
end
