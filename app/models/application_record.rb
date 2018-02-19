require 'enumerable'

class ApplicationRecord < ActiveRecord::Base
  include ApiAttributes
  include Enumerable
  # include Enumerable::Instance
  # extend Enumerable::Klass

  self.abstract_class = true

  class << self
    def attributes
      new.attributes.symbolize_keys.keys.sort
    end
  end
end
