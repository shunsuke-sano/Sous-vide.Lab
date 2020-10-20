class HeaderUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::RMagick



  storage :file

  
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
 process :resize_to_limit => [700, 700]
 
 process :convert => 'jpg'
 
 version :thumb do
   process resize_to_fit: [100, 100]
 end
 
 def extension_whitelist
     %w(jpg jpeg gif png)
 end

 def filename
  super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
 end
  
  version :thumb1 do
    process :resize_to_fill => [100, 100, gravity = ::Magick::CenterGravity]
  end
  
end
