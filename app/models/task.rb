class Task < ApplicationRecord
  include Tasks::Relations

  enumerate :action_type
end
