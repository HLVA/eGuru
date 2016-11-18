OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '225165417541376', '39b6d34e629038d4ed123c0a0581ef70'
end
