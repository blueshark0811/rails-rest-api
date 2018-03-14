class VideoPolicy < OrganizationEntityPolicy
  class << self
    def permitted_attributes_shared
      %i[video_link title]
    end
  end

  def permitted_attributes
    %i[videoable_id videoable_type] + self.class.permitted_attributes_shared
  end

  def sproutvideo?
    true
  end
end
