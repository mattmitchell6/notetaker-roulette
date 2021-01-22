class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # storage :file
end