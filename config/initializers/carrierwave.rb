require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials[:AWS_ACCESS_KEY_ID],
      aws_secret_access_key: Rails.application.credentials[:AWS_SECRET_ACCESS_KEY],
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'fleamarket72e'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/fleamarket72'
  else
    config.strage :file
    config.enable_processing = false if Rails.env.test?
  end
end