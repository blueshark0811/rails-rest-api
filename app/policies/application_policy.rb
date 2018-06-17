class ApplicationPolicy
  include ApiPolicy
  include PolicyHelper::Base

  attr_reader :user_context, :user, :organization, :record, :params

  def initialize(user_context, record)
    @user_context = user_context
    @user = user_context.user
    @organization = user_context.organization
    @params = user_context.params || {}
    @record = record
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
    user && user.id == record.try(:user_id)
  end

  def scope
    Pundit.policy_scope!(user_context, record.class)
  end

  def permitted_attributes
    []
  end

  class Scope
    include PolicyHelper::Base

    attr_reader :user_context, :user, :organization, :scope, :params

    def initialize(user_context, scope)
      @user_context = user_context
      @user = user_context.user
      @organization = user_context.organization
      @params = user_context.params || {}
      @scope = scope
    end

    def condition
      {}
    end

    def none
      { id: -1 }
    end

    def klass
      scope.class == Class ? scope : scope.klass
    rescue
      nil
    end

    def resolve
      sc = scope

      condition.each do |k, v|
        if v.is_a?(Hash)
          next unless klass.attributes.include?(k)
          sc = case v.first.first
          when :not
            sc.where.not(k => v.first.last)
          else
            sc.where(k => v)
          end
        elsif k == :_or
          base_sc = sc

          sc = base_sc.where(v.shift)

          v.each do |cond|
            sc = sc.or(base_sc.where(cond))
          end
        elsif klass.attributes.include?(k)
          sc = sc.where(k => v)
        end
      end

      @scope = sc
    end
  end
end
