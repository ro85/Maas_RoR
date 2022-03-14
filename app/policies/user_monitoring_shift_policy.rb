class UserMonitoringShiftPolicy < ApplicationPolicy
  
  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      else
        scope.where(user: @user)
      end
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def mark_as_available?
    true
  end

end
