class VideoPolicy < OrganizationEntityPolicy
  class << self
    def permitted_attributes_shared
      %i[video_link title description]
    end
  end

  def permitted_attributes_for_create
    %i[videoable_id videoable_type] + self.class.permitted_attributes_shared
  end

  def permitted_attributes_for_update
    %i[title]
  end

  def sproutvideo?
    true
  end

  def get_token?
    true
  end
end
