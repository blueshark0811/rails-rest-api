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
      participated_group_ids: participated_group_ids
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

  def name
    res = [first_name.presence, last_name.presence].compact.join ' '

    res.presence || nickname
  end

  def nickname
    email.split('@').first
  end

  def cached_roles
    @cached_roles ||= organization_users.map { |ou| [ou.organization_id, ou.role].join('_') }
  end

  def in_course?(course)
    !!in_course(course)
  end

  def in_course(course)
    @in_course ||= {}

    return @in_course[course.id] unless @in_course[course.id].nil?

    @in_course[course.id] = course_users.where(course_id: course.id).first
  end

  def in_group_of_course?(course)
    @in_group_of_course ||= {}

    return @in_group_of_course[course.id] unless @in_group_of_course[course.id].nil?

    @in_group_of_course[course.id] = group_users.where(
      group_id: course.course_groups.select(:group_id)
      ).exists?
  end

  def in_course_group?(course_group)
    course_group.course_users.where(user_id: id).exists?
  end

  def in_group?(group)
    return unless group

    group_id = group.is_a?(Group) ? group.id : group

    @in_group ||= {}

    return @in_group[group_id] unless @in_group[group_id].nil?

    @in_group[group_id] = group_users.where(group_id: group_id).exists?
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
