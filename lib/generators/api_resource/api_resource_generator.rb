# frozen_string_literal: true

class ApiResourceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_controller
    set_variables
    @sort_field = :id
    template 'controller.rb', "app/controllers/api/v1/#{plural_name}_controller.rb"
  end

  def create_serializer
    set_variables
    template 'serializer.rb', "app/serializers/api/v1/#{file_name}_serializer.rb"
  end

  def create_policy
    set_variables
    template 'policy.rb', "app/policies/#{file_name}_policy.rb"
  end

  def create_specs
    set_variables
    template 'spec.rb', "spec/integration/#{plural_name}_spec.rb"
  end

  def create_factory
    set_variables
    @associations = @associations.reject { |a| [:has_many].include?(a.macro) }
    @permitted_attributes = @permitted_attributes.reject{ |a| a.match /_id\z/ }

    template 'factory.rb', "spec/factories/#{file_name}_factory.rb"
  end

  def write_route
    routes_file_path = 'config/routes.rb'

    after_line = 'namespace :v1 do'

    new_routes = "resources :#{plural_name}"

    file_content = File.read(routes_file_path)

    return if file_content.include?(new_routes)

    gsub_file routes_file_path, /(#{Regexp.escape(after_line)})/mi do |match|
      "#{match}\n      #{new_routes}"
    end
  end

  protected

  def set_variables
    @model = class_name.constantize
    @associations = @model.reflect_on_all_associations

    excluded = %i[id created_at updated_at confirmation_sent_at confirmed_at current_sign_in_at
                  current_sign_in_ip encrypted_password last_sign_in_at confirmation_token
                  last_sign_in_ip remember_created_at reset_password_sent_at
                  reset_password_token sign_in_count]

    @permitted_attributes = @model.attributes - excluded
  end

  def get_attribute_faker(attribute)
    return '{ Faker::Internet.email }' if attribute.match?(/email/)

    return '{ Faker::Name.name }' if attribute.match?(/name/)

    case @model.column_of_attribute(attribute).type
    when :integer
      'Faker::Number.number(10)'
    when :string
      'Faker::Lorem.sentence'
    when :text
      'Faker::Lorem.paragraph'
    when :datetime, :time, :date
      '1.day.ago'
    when :float, :decimal
      'Faker::Number.positive'
    else
      "''"
    end
  end
end
