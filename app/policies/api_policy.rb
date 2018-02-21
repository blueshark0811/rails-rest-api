module ApiPolicy
  def api_base_attributes
    record.class.attributes
  end

  def api_attributes action = nil
    if action && self.respond_to?(act = "api_attributes_#{action}")
      return self.send act
    end

    api_base_attributes
  end

  def api_attributes_index
    api_attributes
  end

  def api_attributes_show
    api_attributes_index
  end

  def api_attributes_create
    return permitted_attributes_for_create if respond_to?(:permitted_attributes_for_create)
    return permitted_attributes if respond_to?(:permitted_attributes)
    api_attributes_show
  end
  alias_method :api_attributes_new, :api_attributes_create

  def api_attributes_edit
    return permitted_attributes_for_edit if respond_to?(:permitted_attributes_for_edit)
    return permitted_attributes if respond_to?(:permitted_attributes)
    api_attributes_create
  end
  alias_method :api_attributes_update, :api_attributes_edit
end
