class ApiResourceGenerator < Rails::Generators::NamedBase
  ACTIONS = %w[controller serializer policy specs factory route]

  class_option :actions, type: :string
  class_option :searchkick, type: :boolean, default: false

  source_root File.expand_path('../templates', __FILE__)

  def create
    actions = if options['actions']
      options['actions'].split(',').map { |a| a.gsub(/\W/, '').presence }.compact & ACTIONS
    end

    actions ||= ACTIONS

    actions.each do |action|
      p 'do action -> ', action

      send "create_#{action}"
    end
  end

  protected

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
    @associations = @associations.reject{ |a| [:has_many].include?(a.macro) }
    @permitted_attributes = @permitted_attributes.reject{ |a| a.match /_id\z/ }

    template "factory.rb", "spec/factories/#{file_name}_factory.rb"
  end

  def create_route
    write_to_file 'config/routes.rb', "namespace :v1 do", "resources :#{plural_name}", ' '*6
  end

  def set_variables
    @model = class_name.constantize
    @associations = @model.reflect_on_all_associations
    @searchkick = options['searchkick']

    excluded = %i[id created_at updated_at confirmation_sent_at confirmed_at current_sign_in_at
      current_sign_in_ip encrypted_password last_sign_in_at confirmation_token
      last_sign_in_ip remember_created_at reset_password_sent_at
      reset_password_token sign_in_count]

    @permitted_attributes = @model.attributes - excluded
  end

  def get_attribute_faker attribute
    if attribute.match /email/
      return '{ Faker::Internet.email }'
    end

    if attribute.match /name/
      return '{ Faker::Name.name }'
    end

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

  def write_to_file file, after_line, new_content, shift = nil

    file_content = File.read(file)

    return if file_content.include?(new_content)

    gsub_file file, /(#{Regexp.escape(after_line)})/mi do |match|
      "#{match}\n#{shift}#{new_content}"
    end
  end
end
