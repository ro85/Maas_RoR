class WeekdaySetupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user.admin == true
  end

  
end
