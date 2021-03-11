Cloudinary.config do |config|
  config.cloud_name = 'pixnvidzcloud'
  config.api_key = Rails.application.credentials.dig(:cloudinary, :api_key)
  config.api_secret = Rails.application.credentials.dig(:cloudinary, :api_secret)
  config.secure = true
  config.cdn_subdomain = true
end
