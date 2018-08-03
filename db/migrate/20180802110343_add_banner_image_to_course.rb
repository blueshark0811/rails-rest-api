class AddBannerImageToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :banner_image, :string
  end
end
