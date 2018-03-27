class User < ApplicationRecord
  include Users::Relations
  include Users::Api
  SEARCH_FIELDS = %i[first_name last_name email]
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerate :admin_role, :status

  mount_base64_uploader :avatar, AvatarUploader

  searchkick callbacks: :async, word_start: SEARCH_FIELDS
  def search_data
    attributes.merge(
      'first_name' => first_name || '',
      organization_ids: organization_ids,
      roles: cached_roles,
      group_ids: group_ids
    )
  end

  before_validation :set_temp_passsword, on: :create

  accepts_nested_attributes_for :organization_users

  attr_accessor :current_organization

  class << self
    def additional_attributes
      { organization_settings: {
          type: :association,
          association: :organization_users,
          association_type: :object,
          mode: :inside_current_organization,
          null: true
        }
      }
    end
  end

  def cached_roles
    @cached_roles ||= organization_users.map{|ou| [ou.organization_id, ou.role].join('_')}
  end

  def current_organization_user(organization = nil)
    return unless organization ||= current_organization

    organization_users.find_by(organization_id: organization.id)
  end

  def role(organization = nil)
    return unless organization ||= current_organization

    @role ||= {}
    @role[organization.id] ||= current_organization_user(organization)&.role
  end

  def organization_status(organization = nil)
    return unless organization ||= current_organization

    @organization_status ||= {}
    @organization_status[organization.id] ||= current_organization_user(organization)&.status
  end

  protected

  def set_temp_passsword
    return if password.present?

    self.password = Devise.friendly_token.first(8)
    self.password_confirmation = password
  end
end
