class TreeableJob < ApplicationJob
  ACTIONS = %w[updated]

  queue_as :important

  def perform(object, options = {})
    action = options.fetch('action', 'updated')

    @options = options

    return unless ACTIONS.include? action

    send "#{action}_treeable", object
  end

  protected

  def updated_treeable(object)
    if @options['tree_path_field']
      object.tree_path_recache

      if @options['main_root_foreign_key']
        object.send("#{@options['main_root_foreign_key']}=", object.tree_path_recache.first || object.id)
      end

      object.save
    elsif @options['main_root_foreign_key']
      object.update(@options['main_root_foreign_key'] => object.main_root.id)
    end
  end
end
