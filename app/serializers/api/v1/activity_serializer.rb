class Api::V1::ActivitySerializer < BaseSerializer
  include ApiSerializer
  
  belongs_to :eventable
  belongs_to :notifiable
end
