Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps, domain: 'shopkeep.com'
end
