class IconUploader < CarrierWave::Uploader::Base
 
  
  include CarrierWave::RMagick



  storage :file

  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

 
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


