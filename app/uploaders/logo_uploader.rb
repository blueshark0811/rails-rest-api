class LogoUploader < ImageUploader

  version :display do
    process resize_to_fill: [160, 55]
  end
end
