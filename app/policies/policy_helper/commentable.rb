module PolicyHelper
  module Commentable
    def comments_index?
      show?
    end

    def comments_create?
      update?
    end

    def comments_update?
      comments_create? && author?
    end

    def comments_destroy?
      comments_update?
    end
  end
end
