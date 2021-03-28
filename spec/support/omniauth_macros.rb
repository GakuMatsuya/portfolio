module OmniauthMacros
  def google_mock
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "12345",
      info: {
        name:  "mockuser",
        email:  "mock@example.com"
      },
    })
  end
end