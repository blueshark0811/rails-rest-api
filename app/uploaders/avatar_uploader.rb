class AvatarUploader < ImageUploader

  version :small do
    process resize_to_fill: [35, 35]
  end

  version :middle do
    process resize_to_fill: [98, 98]
  end
end
