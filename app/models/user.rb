class User < ApplicationRecord
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enumirate :admin_role, :status

  belongs_to :country, optional: true
  belongs_to :state, optional: true
  has_many :organization_users
  has_many :organizations, through: :organization_users
  has_many :group_users
  has_many :groups, through: :group_users

  before_validation :set_default_data

  def remember_expired?
    remember_expires_at < Time.zone.now
  end

  private

  def set_default_data
    self.status ||= 'active'
  end
end
