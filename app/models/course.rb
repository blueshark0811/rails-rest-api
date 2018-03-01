class Course < ApplicationRecord
  include Courses::Relations

  mount_base64_uploader :image, ImageUploader
end
