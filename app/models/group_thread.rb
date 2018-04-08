class GroupThread < ApplicationRecord
  SORT_FIELDS = %w(title created_at comments_count last_activity_at)

  belongs_to :user
  belongs_to :group
  has_one :organization, through: :group
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: [:group_id] }

  def organization_id
    organization&.id
  end

  def comment_created_callback(comment)
    self.comments_count += kount
    self.last_activity_at = Time.zone.now

    save(validate: false)
  end

  def last_comment
    comments.last
  end

  class << self
    def additional_attributes
      {
        last_comment: {
          null: true,
          type: :object
        }
      }
    end
  end
end
