#config/initializers/carrierwave.rb

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider              => 'AWS',
    :aws_access_key_id     => 'AKIAI5IDBNSEJHNF4PTQ',
    :aws_secret_access_key  => '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',
    :region                => 'us-west-2'
  }

  # For testing, upload files to local `tmp` folder.
  # if Rails.env.development?
  #   config.storage = :file
  #   config.enable_processing = false
  #   config.root = "#{Rails.root}/tmp"
  # else
  #   config.storage = :fog
  # end

  # config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

  config.fog_directory    = 'alomam'
end