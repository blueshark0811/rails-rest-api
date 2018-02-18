class Action < ApplicationRecord
  include Actions::Relations

  enumerate :action_type
end
