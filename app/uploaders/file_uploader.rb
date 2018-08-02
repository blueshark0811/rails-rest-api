# require 'carrierwave/processing/mime_types'
class FileUploader < CarrierWave::Uploader::Base
	include CarrierWave::MiniMagick
  include CarrierWave::RMagick
  include CarrierWave::Video
  include CarrierWave::Video::Thumbnailer
  include CarrierWave::FFmpeg
  
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png mov mp4 3gp webm m4v avi pdf ppt pptx doc docx zip xlsx xls csv mp3 wav mpg)
  end
end
