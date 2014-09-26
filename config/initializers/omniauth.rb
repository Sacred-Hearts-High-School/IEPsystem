OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1092282053883-4trh1rc9m9j8kq5su7r843q3mj6septd.apps.googleusercontent.com', 'VKB48Bw_GfRtnYtIL3fdi0AQ',{ access_type: "offline", approval_prompt: "" }
end
