class Activity < ApplicationRecord
  EVENTABLES = %w[Comment ChatMessage]
  NOTIFIABLES = %w[User Group]
  SORT_FIELDS = %w[created_at flagged status]

  # what trigger notification
  belongs_to :eventable, polymorphic: true
  # what should be notify
  belongs_to :notifiable, polymorphic: true

  # author of activity, for example: Peter wrote comment -> user:Peter eventable:Comment
  belongs_to :user

  # enviroment of activity, where it happened, for quick select...
  belongs_to  :task, optional: true
  belongs_to :lesson, optional: true
  belongs_to :course, optional: true
  belongs_to :group, optional: true
  belongs_to :organization, optional: true
  ###

  before_validation :set_default_data, on: :create

  after_create_commit { ActivityJob.perform_later self }

  validates :message, presence: true

  # as_object should contain i18n path and variables if should be passed to localization
  store_accessor :message, :plain, :as_object, :teacher_ids
  # teacher_ids: [id, id....]

  enumerate :status

  def excluded_from_broadcast?
    return false unless organization_id

    return false if notifiable_type != 'User'

    organization_user = notifiable.organization_users.find_by(organization_id: organization_id)

    return false unless organization_user

    if !organization_user.activity_course_ids.blank? && course_id
      return true unless organization_user.activity_course_ids.include?(course_id)
    end

    if !organization_user.activity_student_ids.blank? && user_id
      return true unless organization_user.activity_student_ids.include?(user_id)
    end

    false
  end

  def add_teacher!(user)
    update teacher_ids: (Array(teacher_ids)+[user]).uniq
  end

  def teachers
    return [] if teacher_ids.blank?

    User.where id: teacher_ids
  end

  def plain_message
    return plain if plain.presence

    path = as_object['i18n'].is_a?(String) ? as_object['i18n'] : as_object['i18n'].join('.')
    I18n.t("activity.messages.#{path}", (as_object['variables'] || {}).with_indifferent_access)
  end

  def channel
    self.class.channel notifiable
  end

  class << self
    def mark_as_read teacher, lesson
      teacher.activities.where(lesson: lesson).update_all status: 'read'
    end

    def additional_attributes
      {
        teachers: {
          null: true,
          type: :association,
          description: 'teachers that answered to this activity',
          association: :teachers,
          association_type: :array,
          items: { type: :object, properties: {} },
          for_roles: 'teacher'
        }
      }
    end

    def channel(notifiable)
      [notifiable.class.name.downcase, notifiable.id, "activity_channel"].join('_')
    end

    def message_link(object, title = nil)
      object = OpenStruct.new(object) if object.is_a?(Hash)
      object_type = object.try(:object_type) || object.class.name

      title ||= object.try(:title)
      title ||= object.try(:name)
      title ||= object_type

      "<a href='#' data-object-id='#{object.id}' data-object-type='#{object_type}'>#{title}</a>"
    end
  end

  protected

  def set_default_data
    self.lesson_id = task.lesson_id if lesson_id.blank? && task_id

    if course_id.blank?
      self.course_id = lesson.course_id if lesson_id
      self.course_id ||= task.course_id if task_id
    end

    if organization_id.blank?
      self.organization_id = group.organization_id if group_id
      # self.organization_id ||= course.organization_id if course_id
    end
  end
end
