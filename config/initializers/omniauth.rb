OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '600186960136254', '76c36f0a7f31dbc0e97571b53ac831a8'
end