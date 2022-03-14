class MonitoringShiftPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve    
      scope.all      
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

  def tildar_todas?
    true
  end

end
