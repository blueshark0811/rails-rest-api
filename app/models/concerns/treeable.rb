# frozen_string_literal: true

module Treeable
  extend ActiveSupport::Concern

  module ClassMethods
    def treeable(options = {})
      if options[:tree_path_field]
        #field should be as array in postgres db
        # serialize options[:tree_path_field], Array

        scope :tree, -> (root_id = nil) {
          sc = #select("*, array_to_string(#{options[:tree_path_field]}, '-') as tpath")
            where("array_length(#{options[:tree_path_field]}, 1) > 0")
            .order("array_to_string(#{options[:tree_path_field]}, '-') ASC")

            if root_id
              sc = sc.where("? = ANY(#{options[:tree_path_field]})", root_id.to_s)
                .where.not(id: root_id)
            end
          
          sc
        }
      end

      belongs_to(
        :root,
        optional: true,
        class_name: name,
        counter_cache: options.fetch(:counter_cache, false)
      )
      has_many :children, foreign_key: :root_id, class_name: name, dependent: :destroy
      has_many :all_children, foreign_key: :main_root_id, class_name: name, dependent: :destroy
      scope :roots, -> { where root_id: nil }

      after_save do
        p saved_changes
        if saved_changes['root_id'].present? || saved_changes['id'].present?
          options.each_with_object(opts = {}) { |(v, k), h| h[v.to_s] = k.to_s; }
          TreeableJob.perform_later self, opts
        end
      end

      define_method :root? do
        root_id.blank?
      end

      define_method :children_exist? do
        count_children.to_i.positive?
      end

      define_method :child? do
        root_id.present?
      end

      define_method :main_root do
        root? ? self : root&.main_root
      end

      if options[:tree_path_field]
        define_method :tree_path_recache! do
          tree_path_recache
          save
        end

        define_method :tree_level do
          send(options[:tree_path_field]).count-1
        end

        define_method :tree_path_recache do
          send("#{options[:tree_path_field]}=", [id])

          obj = self

          while obj.child? do
            send(options[:tree_path_field]) << obj.root_id if obj.root_id
            obj = obj.root
          end

          send(options[:tree_path_field]).reverse!
        end
      end
    end
  end
end
