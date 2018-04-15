# frozen_string_literal: true

class Group < ApplicationRecord
  include Groups::Relations
  SEARCH_FIELDS = %i[description title]

  searchkick callbacks: :async, word_start: SEARCH_FIELDS, searchable: SEARCH_FIELDS
  def search_data
    attributes.merge(
      user_ids: user_ids
    )
  end

  enumerate :status, field: :visibility, prefix: true
  store_accessor :noticeboard_settings, :noticeboard_enabled, :student_can_post, :student_can_comment

  validates :organization_id, :title, :status, :visibility, presence: true

  scope :participated_by, lambda { |user|
    joins(:group_users).where(group_users: { user_id: user.id })
  }

  class << self
    def additional_attributes
      {
        noticeboard_enabled: {
          type: :boolean
        },
        student_can_post: {
          type: :boolean
        },
        student_can_comment: {
          type: :boolean
        },
        participated: {
          type: :association,
          association: :group_users,
          association_type: :object,
          mode: :for_current_user,
          null: true,
          description: 'group_user instance for current user if he participated in group'
        }
      }
    end
  end

  def student_can_post
    noticeboard_enabled && super
  end

  def student_can_comment
    noticeboard_enabled && super
  end

  def add_user_to_courses(user)
    courses.each do |course|
      course_group = course.course_groups.find_by(group_id: id)
      course.course_users.create user: user, course_group: course_group
    end
  end

  def count_participants
    super.to_i
  end
end
