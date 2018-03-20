class ApplicationJob < ActiveJob::Base
  # self.queue_adapter = :resque
  # before_perform do |job|
  #   ActiveRecord::Base.clear_active_connections!
  # end
end
