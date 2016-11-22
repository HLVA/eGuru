OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '225165417541376', '39b6d34e629038d4ed123c0a0581ef70', {:scope => "user_friends"}
  provider :google_oauth2, '965953041324-2k3jcilnocjhn0cb7h899h4kdf9utdnb.apps.googleusercontent.com', 'WjQVpAemyU1sRMIWFV-t3099', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
