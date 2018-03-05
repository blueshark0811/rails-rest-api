class VideoPolicy < OrganizationEntityPolicy
  def permitted_attributes
    %i[videoable_id videoable_type description video length title]
  end
end
