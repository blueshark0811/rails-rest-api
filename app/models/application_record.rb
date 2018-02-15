class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def attributes
      new.attributes.symbolize_keys.keys.sort
    end

    def enumerate *fields
      prefix = nil
      suffix = nil

      fields.each do |field|
        if field.is_a?(Hash)
          prefix = field[:prefix] || suffix = field[:suffix]
          field = field[:field]
        end

        enum(
            field => enumeration_labels(field).inject({}) { |h, (k, _v)| h[k] = k; h }, 
            _prefix: prefix, 
            _suffix: suffix
            )
      end
    end

    def enumeration_labels field
      MODELS[name.underscore][field.to_s.pluralize]
    end

    def enumeration_key_by_index field, index
      enumeration_labels(field).to_a[index.to_i].first
    end

    def enumeration_label_by_index field, index
      enumeration_labels(field).to_a[index.to_i].last
    end
  end

  def error_keys field
    errors.details[field]&.map{|w| w[:error]}
  end
end
