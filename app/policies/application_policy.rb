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
    @role ||= user&.role(organization)
  end

  OrganizationUser.roles.keys.each do |rol|
    define_method "#{rol}?" do
      role == rol || rol == 'admin' && super_admin?
    end
  end

  def super_admin?
    user.super_admin?
  end

  def index?
    admin?
  end

  def show?
    admin?
  end

  def create?
    admin?
  end

  def new?
    create?
  end

  def update?
    super_admin? || author?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def author?
    user.id == record.try(:user_id)
  end

  def scope
    Pundit.policy_scope!(user_context, record.class)
  end

  def permitted_attributes
    []
  end

  class Scope
    attr_reader :user_context, :user, :organization, :scope

    def initialize(user_context, scope)
      @user_context = user_context
      @user = user_context.user
      @organization = user_context.organization
      @scope = scope
    end

    def condition
      {}
    end

    def none
      { id: -1 }
    end

    def resolve
      scope.where(condition)
    end

    def resolve
      scope
    end
    
    def role
      @role ||= user&.role(organization)
    end
  end
end
