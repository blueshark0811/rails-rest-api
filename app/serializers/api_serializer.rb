module ApiSerializer
  extend ActiveSupport::Concern

  module ClassMethods
    def serializable_class_name
      @serializable_class_name ||= name.split('::').last.gsub(/Serializer/, '')
    end

    def serializable_class
      return @serializable_class if @serializable_class

      return unless Object.const_defined?(serializable_class_name)

      @serializable_class = Object.const_get serializable_class_name
    end

    def base_attributes
      return [] unless serializable_class

      serializable_class.policy_base_attributes
    end
  end

  def attributes(requested_attrs = nil, reload = false)
    @attributes = nil if reload

    return  @attributes if @attributes

    attrs = (self.class._attributes_data.keys | self.class.base_attributes)

    @attributes = attrs.each_with_object({}) do |(field), hash|
      attr = ActiveModel::Serializer::Attribute.new(field, {})

      next if attr.excluded?(self)
      next unless requested_attrs.nil? || requested_attrs.include?(field)
      hash[label_field(field)] = attr.value(self)
    end
  end

  def label_field(field)
    klass.column_of_attribute(field).try(:label) || field
  end

  def klass
    if real_object.is_a?(Searchkick::HashWrapper) && searchkickable_class
      searchkickable_class
    else
      real_object.class
    end
  end

  def read_attribute_for_serialization(attr)
    return ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE if attr.is_a?(Hash)

    return send(attr) if respond_to?(attr)

    return type_cast(attr) if available_fields.include?(attr)

    #associations
    if assoc = self.class.serializable_class.reflect_on_association(attr)
      if %i[belongs_to has_one].include?(assoc.macro) && !too_deeply?# @checkme
        return type_cast_object(object.read_attribute_for_serialization(attr))
      end

      return object.read_attribute_for_serialization(attr)
    end

    ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE
  end

  def available_fields
    key = params[:action] || :base

    @available_fields ||= {}

    return @available_fields[key] if @available_fields[key]

    return [] unless self.class.serializable_class

    @available_fields[key] = if object.is_a?(self.class.serializable_class)
      object.policy_available_attribute(user_context, params[:action])
    else#in case searchkick
      return [] unless pclass = self.class.serializable_class.policy_klass

      pclass.new(user_context, object).api_attributes(params[:action])
    end

    @available_fields[key]
  end

  def real_object
    return @real_object if @real_object

    return object unless real_collection
    return object unless object.is_a?(Searchkick::HashWrapper)

    @real_object = real_collection[object.id] || object
  end

  def type_cast(field)
    res = nil
    col = klass.column_of_attribute(field)

    if (conditions = col.try(:param_conditions)) && conditions.any? { |k, v| params[k] != v }
      return ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE
    end

    if (for_roles = col.try(:for_roles)) && Array(for_roles).none? { |role| for_roles == role }
      return ActiveModel::FieldUpgrade::ATTR_NOT_ACCEPTABLE
    end

    res = object.send(field) if object.respond_to?(field)
    res = real_object.send(field) if res.nil? && real_object.respond_to?(field)

    begin
      case col.type
      when :integer
        res = res.to_i

      when :float
        res = res ? res.ceil(2) : 0

      when :string
        if klass.uploaders.has_key?(field.to_sym)
          if res.is_a?(String)
            res = JSON.parse(res.to_s) rescue res
          end
        else
          res = res.to_s
        end
      when :datetime
        res = res.to_s(:long) if res && !res.is_a?(String)

      when :object
        res = type_cast_object(res)
      when :association
        res = res.is_a?(Array) && res.blank? ? res : type_cast_association(res, col)
      end
    rescue => e
      p 'error type_cast -> ', field, e
    end

    res
  end

  def type_cast_object(res)
    return unless res
    res.class.serializer_class_name.constantize.new(
      res,
      serializer_params: serializer_params.merge(current_deep: current_deep + 1)
      ).serializable_hash
  end

  def mode_condition(cond, mode)
    case mode
    when :inside_current_organization
      cond[:organization_id] = current_organization ? current_organization.id : -1
    when :for_current_user
      cond[:user_id] = current_user ? current_user.id : -1
    when :for_current_student
      cond[:user_id] = current_student ? current_student.id : -1
    when :for_current_group
      cond[:group_id] = current_group ? current_group.id : -1
    when :for_current_course
      cond[:course_id] = current_course ? current_course.id : -1
    when :for_current_course_group
      cond[:course_group_id] = current_course_group ? current_course_group.id : -1
    end

    cond
  end

  def type_cast_association(res, col)
    return res unless real_object.respond_to?(col.association)

    res = real_object.send(col.association)

    cond = {}

    # remove later when will be moved all :mode => :modes
    cond = mode_condition(cond, col.mode) if col.try(:mode)

    if modes = col.try(:modes)
      modes.each { |mode| cond = mode_condition(cond, mode) }
    end

    if with_params = col.try(:with_params)
      with_params.each do |param|
        cond_key, param_key = param.is_a?(Hash) ? param.to_a : [param, param]

        cond[cond_key] = params[param_key]
      end
    end

    case col.try(:association_type)
    when :object
      res = cond.blank? ? res.last : res.find_by(cond)

      res = type_cast_object(res)
    when :array
      res = res.where(cond) unless cond.blank?

      kls = res.new.class.serializer_class_name.constantize

      res = res.map { |r|
        r.new_record? ? nil :
          kls.new(r,
            serializer_params: serializer_params.merge(current_deep: current_deep + 1)
          ).serializable_hash
      }.compact
    else
      #something, like array
    end

    res
  end

  def searchkickable_class
    object._type.classify.constantize rescue nil
  end
end
