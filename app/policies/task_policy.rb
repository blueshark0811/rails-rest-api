class TaskPolicy < OrganizationEntityPolicy
  def permitted_attributes
    attrs = %i[action_type description]

    attrs << {
      attachments_attributes: %i[id] + AttachmentPolicy.permitted_attributes_shared
    }

    attrs << {
      videos_attributes: %i[id] + VideoPolicy.permitted_attributes_shared
    }

    attrs
  end
end
