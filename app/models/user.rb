class User < ApplicationRecord
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enumirate :role, :admin_role

  belongs_to :country, optional: true
  belongs_to :state, optional: true

  def remember_expired?
    remember_expires_at < Time.zone.now
  end
end
