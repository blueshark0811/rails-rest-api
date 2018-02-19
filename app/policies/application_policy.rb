class ApplicationPolicy
  include ApiPolicy

  attr_reader :user, :organization, :record

  def initialize(user, organization, record)
    @user = user
    @record = record
    @organization = organization
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
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
    Pundit.policy_scope!(user, organization, record.class)
  end

  class Scope
    attr_reader :user, :organization, :scope

    def initialize(user, organization, scope)
      @user = user
      @organization = organization
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
