class ApplicationPolicy
  include ApiPolicy

  attr_reader :user_context, :user, :organization, :record

  def initialize(user_context, record)
    @user_context = user_context
    @user = user_context.user
    @organization = user_context.organization
    @record = record
  end

  def role
    @role ||= user.role(organization)
  end

  def super_admin?
    user.super_admin?
  end

  OrganizationUser.roles.keys.each do |rol|
    define_method "#{rol}?" do
      role == rol
    end
  end

  def index?
    super_admin? || admin?
  end

  def show?
    super_admin? || admin?
  end

  def create?
    super_admin?
  end

  def new?
    create?
  end

  def update?
    super_admin?
  end

  def edit?
    update?
  end

  def destroy?
    super_admin?
  end

  def scope
    Pundit.policy_scope!(user_context, record.class)
  end

  class Scope
    attr_reader :user_context, :user, :organization, :scope

    def initialize(user_context, scope)
      @user_context = user_context
      @user = user_context.user
      @organization = user_context.organization
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
