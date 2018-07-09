class TaskUser < ApplicationRecord
  belongs_to :task

  has_one :lesson, through: :task
  has_many :lesson_users, through: :lesson

  belongs_to :user

  belongs_to :course_group
  has_one :group, through: :course_group
  has_one :course, through: :course_group
  has_one :organization, through: :group

  enumerate :status

  delegate :description, to: :task

  validates :user_id, uniqueness: { scope: [:task_id, :course_group_id] }

  def comment_created_callback(comment)
    attachment_comment_created_callback(comment)
  end

  def attachment_created_callback(attachment)
    attachment_comment_created_callback(attachment)
  end

  protected

  def notify_teacher(teacher, attach_or_comment)
    teacher.activities.create(
      eventable: attach_or_comment,

      user: attach_or_comment.user,
      task_id: task_id,
      lesson_id: lesson_id,
      course_id: course_group.course_id,
      group_id: course_group.group_id,
      organization_id: organization&.id,

      as_object: {
        i18n: "#{attach_or_comment.class.name.underscore}.task_user.created",
        variables: {
          user: Activity.message_link(attach_or_comment.user),
          task: Activity.message_link(task),
          lesson: Activity.message_link(lesson)
        }
      }
    )
  end

  def attachment_comment_created_callback(attach_or_comment)
    if user.role(organization) == 'student'
      group.teachers.each do |teacher|
        notify_teacher(teacher, attach_or_comment)
      end
    else
      Activity.where(notifiable: group.teachers).find_each do |activity|
        activity.add_teacher user
      end
    end
  end
end
