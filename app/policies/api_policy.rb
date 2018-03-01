module ApiPolicy
  #for override
  def api_base_attributes_exclude
    []
  end

  def api_base_attributes
    if record.is_a?(Searchkick::HashWrapper)
      record.keys.map(&:to_sym).reject{|k| k.match(/\A_|\Asort\z/) }
    else
      record.api_base_attributes.reject{|k| api_base_attributes_exclude.include?(k) }
    end
  end

  def api_attributes action = nil
    if action && respond_to?(act = "api_attributes_#{action}")
      return send(act)
    end

    api_base_attributes
  end

  def api_attributes_index
    return permitted_attributes_for_index if respond_to?(:permitted_attributes_for_index)
    api_attributes
  end

  def api_attributes_show
    return permitted_attributes_for_show if respond_to?(:permitted_attributes_for_show)
    api_attributes_index
  end

  def api_attributes_create
    return permitted_attributes_for_create if respond_to?(:permitted_attributes_for_create)
    return permitted_attributes if respond_to?(:permitted_attributes)
    api_attributes_show
  end
  alias_method :api_attributes_new, :api_attributes_create

  def api_attributes_edit
    return permitted_attributes_for_update if respond_to?(:permitted_attributes_for_update)
    return permitted_attributes if respond_to?(:permitted_attributes)
    api_attributes_create
  end
  alias_method :api_attributes_update, :api_attributes_edit
end
