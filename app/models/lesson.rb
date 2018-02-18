class Lesson < ApplicationRecord
  include Lessons::Relations

  enumerate :status
end
