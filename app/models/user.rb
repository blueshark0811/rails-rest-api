class User < ApplicationRecord
  include Users::Relations
  include Users::Api
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerate :admin_role, :status

  mount_uploader :avatar, AvatarUploader

  before_validation :set_default_data

  def remember_expired?
    remember_expires_at < Time.zone.now
  end

  private

  def set_default_data
    self.status ||= 'active'
  end
end
