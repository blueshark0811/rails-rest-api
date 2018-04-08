class LessonUser < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
  belongs_to :course_group

  enumerate :status

  def course_settings
    course_group
  end

  class << self
    def additional_attributes
      {
        course_settings: {
          null: true,
          type: :object,
          description: 'course settings for current group'
        }
      }
    end
  end
end
