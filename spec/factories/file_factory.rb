class FakeFile 
  def self.file
    "data:image/jpeg;base64,#{Base64.strict_encode64(File.read(Rails.root.join('spec', 'factories', 'test.jpg')))}"
  end
end
