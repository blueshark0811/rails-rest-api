module PolicyHelper
  module Commentable
    def comments_index?
      show?
    end

    def comments_create?
      update?
    end

    def comments_update?
      comments_create?
    end

    def comments_destroy?
      comments_create?
    end
  end
end