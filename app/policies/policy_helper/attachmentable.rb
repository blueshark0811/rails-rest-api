module PolicyHelper
  module Attachmentable
    def attachments_index?
      show?
    end

    def attachments_create?
      update?
    end

    def attachments_update?
      attachments_create?
    end

    def attachments_destroy?
      attachments_create?
    end
  end
end