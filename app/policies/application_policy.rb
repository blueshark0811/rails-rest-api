class ApplicationPolicy
  include ApiPolicy
  include PolicyHelper::Base

  attr_reader :user_context, :user, :organization, :record

  def initialize(user_context, record)
    @user_context = user_context
    @user = user_context.user
    @organization = user_context.organization
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

    def klass #todo optimize
      scope.new.is_a?(ApplicationRecord) ? scope : scope.klass
    rescue
      scope.klass
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
          sc = sc.where(v.shift)

          v.each do |cond|
            sc = sc.or(sc.where(cond))
          end
        elsif klass.attributes.include?(k)
          sc = sc.where(k => v)
        end
      end

      @scope = sc
    end
  end
end
