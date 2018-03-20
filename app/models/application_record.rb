require 'enumerable'

class ApplicationRecord < ActiveRecord::Base
  include ApiAttributes
  include Enumerable
  include Treeable

  self.abstract_class = true

  class << self
    def attributes
      new.attributes.symbolize_keys.keys.sort
    end
  end

  # for debuging and testing
  def error_keys(field)
    errors.details[field]&.map { |w| w[:error] }
  end
end
