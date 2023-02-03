module SignInSupport

  def basic_pass(path)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  def sign_in(user)
    @user = FactoryBot.create(:user)
    basic_pass root_path
    visit new_user_session_path
    fill_in 'email', with: @drink1.user.email
    fill_in 'password', with: @drink1.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
  end
end