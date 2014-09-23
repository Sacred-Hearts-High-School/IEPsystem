OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '12345678.apps.googleusercontent.com', 'YOUR_SECRET',{ access_type: "offline", approval_prompt: "" }
end
