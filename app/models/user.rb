class User < ApplicationRecord
  include Users::Relations
  include Users::Api
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerate :admin_role, :status

  mount_uploader :avatar, AvatarUploader

  def role organization
    @role ||= {}
    @role[organization.id] ||= organization_users.find_by(organization_id: organization.id)&.role
  end
end
