class Course < ApplicationRecord
  include Courses::Relations
  SORT_FIELDS = %w[title created_at]

  mount_base64_uploader :image, ImageUploader
end
