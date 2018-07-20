class GroupUser < ApplicationRecord
  SORT_SIMLE_FIELDS = %w[created_at status]
  SORT_USER_FIELDS = %w[last_name first_name]
  SORT_FIELDS = %w[role] + SORT_USER_FIELDS+SORT_SIMLE_FIELDS

  searchkick callbacks: :async
  def search_data
    {
      first_name: first_name || '',
      last_name: last_name || '',
      role: role || '',
      status: status || '',
      user_id: user_id,
      date_added: created_at,
      organization_id: organization_id
    }
  end

  belongs_to :user
  belongs_to :group, counter_cache: :count_participants

  enumerate :status

  validates :user_id, uniqueness: { scope: [:group_id] }

  validate :validate_limit_participants, on: :create

  after_create_commit { GroupUserJob.perform_later self }

  after_create_commit { user.reindex }
  after_destroy_commit { user.reindex }

  after_create_commit { group.reindex }
  after_destroy_commit { group.reindex }

  delegate :first_name, :last_name, to: :user, allow_nil: true

  scope :order_by, ->(sort_field, sort_flag = SORT_FLAGS.first) do
    return unless SORT_FIELDS.include? sort_field

    sort_flag = sort_flag.to_s.upcase

    sort_flag = SORT_FLAGS.include?(sort_flag) ? sort_flag : SORT_FLAGS.first

    if SORT_SIMLE_FIELDS.include?(sort_field)
      order(sort_field => sort_flag)
    elsif SORT_USER_FIELDS.include?(sort_field)
      joins(:user).order("users.#{sort_field}" => sort_flag)
    else#role
      #todo
    end
  end

  def role
    organization_user&.role || ''
  end

  def organization_id
    group&.organization_id
  end

  def organization_user
    return unless group&.organization

    @organization_user ||= OrganizationUser.find_by(
      user_id: user_id,
      organization_id: group.organization.id
      )
  end

  class << self
    def additional_attributes
      {
        first_name: { type: :string },
        last_name: { type: :string },
        role: { type: :string },
        organization_id: { type: :integer }
      }
    end
  end

  protected

  def validate_limit_participants
    return if !group || !group.user_limit || group.user_limit > group.group_users.count

    errors.add :group_id, :limit_reached
    false
  end
end
