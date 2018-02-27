class Course < ApplicationRecord
  include Courses::Relations

  mount_uploader :image, ImageUploader
end
