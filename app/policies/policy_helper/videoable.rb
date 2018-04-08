module PolicyHelper
  module Videoable
    def videos_index?
      show?
    end

    def videos_create?
      update?
    end

    def videos_get_token?
      videos_create?
    end

    def videos_update?
      videos_create?
    end

    def videos_destroy?
      videos_create?
    end
  end
end