class ApplicationPolicy
  include ApiPolicy

  attr_reader :user_context, :record

  def initialize(user_context, record)
    @user = user_context.user
    @organization = user_context.organization
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user_context, record.class)
  end

  class Scope
    attr_reader :user_context, :scope

    def initialize(user_context, record)
      @user = user_context.user
      @organization = user_context.organization
      @record = record
    end

    def resolve
      scope
    end
  end
end
