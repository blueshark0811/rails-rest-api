class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def attributes
      new.attributes.symbolize_keys.keys.sort
    end

    def enumirate *fields
      fields.each do |field|
        enum field => enumiration_labels(field).inject({}) { |h, (k, v)| h[k] = k; h } 
      end
    end

    def enumiration_labels field
      MODELS[name.underscore][field.to_s.pluralize]
    end

    def enumiration_key_by_index field, index
      enumiration_labels(field).to_a[index.to_i].first
    end

    def enumiration_label_by_index field, index
      enumiration_labels(field).to_a[index.to_i].last
    end
  end

  def error_keys field
    errors.details[field]&.map{|w| w[:error]}
  end
end
