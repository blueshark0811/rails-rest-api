class ApplicationRecord < ActiveRecord::Base
  include ApiAttributes
  
  self.abstract_class = true
  mattr_accessor :enumerate_fields

  class << self
    def attributes
      new.attributes.symbolize_keys.keys.sort
    end

    def enumerate *fields
      @@enumerate_fields ||= {}.with_indifferent_access
      @@enumerate_fields[name.underscore] = {}

      fields.each do |field|
        if field.is_a?(Hash)
          prefix = field[:prefix] || suffix = field[:suffix]
          set_default = field[:set_default]
          field = field[:field]
        else
          prefix = nil
          suffix = nil
          set_default = nil
        end

        @@enumerate_fields[name.underscore][field] = {
          field => enumeration_labels(field).inject({}) { |h, (k, _v)| h[k] = k; h },
          _prefix: prefix,
          _suffix: suffix
        }

        enum @@enumerate_fields[name.underscore][field]

        @@enumerate_fields[name.underscore][field][:set_default] = set_default
      end

      before_validation :set_default_enum_fields
    end

    def enumeration_labels field
      if res = MODELS[name.underscore][field.to_s.pluralize]
        return res
      end

      raise("Please set list of values in config/model.yml for model '#{name.underscore}' with key '#{field.to_s.pluralize}'")
    end

    def enumeration_key_by_index field, index
      enumeration_labels(field).to_a[index.to_i].first
    end

    def enumeration_label_by_index field, index
      enumeration_labels(field).to_a[index.to_i].last
    end
  end

  protected

  def set_default_enum_fields
    defined_enums.each do |field, values|
      next if self.class.enumerate_fields[self.class.name.underscore][field][:set_default] === false

      self.send("#{field}=", values.to_a.first.first) if self.send(field).blank?
    end
  end
end
