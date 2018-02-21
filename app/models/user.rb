class User < ApplicationRecord
  include Users::Relations
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerate :admin_role, :status

  mount_uploader :avatar, AvatarUploader

  before_validation :set_default_data

def remember_expired?
    !remember_created_at || remember_expire_at < Time.zone.now
  end

  def remember_expire_at
    return unless remember_created_at

    remember_created_at+self.class.remember_for
  end

  private

  def set_default_data
    self.status ||= 'active'
  end
end