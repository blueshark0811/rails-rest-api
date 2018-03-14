class Task < ApplicationRecord
  include Tasks::Relations

  enumerate :action_type

  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :videos

  def organization_id
    @organization_id ||= course&.organization_id
  end
end
