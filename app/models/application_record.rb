require 'enumerable'

class ApplicationRecord < ActiveRecord::Base
  include ApiAttributes
  include Enumerable

  self.abstract_class = true

  class << self
    def attributes
      new.attributes.symbolize_keys.keys.sort
    end
  end

  def error_keys field
    errors.details[field]&.map{ |w| w[:error] }
  end
end
