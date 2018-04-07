class GroupUserJob < ApplicationJob
  queue_as :default

  def perform(group_user)
    group_user.group.add_user_to_courses group_user.user
  end
end
