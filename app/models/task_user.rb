class TaskUser < ApplicationRecord
  belongs_to :task
  has_one :lesson, through: :task
  has_many :lesson_users, through: :lesson
  belongs_to :user
  belongs_to :course_group

  def comment_created_callback(comment)#todo think which activity create
    lesson_user = lesson_users.find_by(user_id: comment.user_id, course_group_id: course_group_id)

    return unless lesson_user

    lesson_user.activities.create(
      eventable: comment,
      user: comment.user,
      task: self,
      as_object: {
        i18n: 'comment.lesson_user.created',
        variables: {
          user: Activity.message_link(comment.user),
          lesson: Activity.message_link(lesson),
          task: Activity.message_link(task)
        }
      }
    )
  end
end
