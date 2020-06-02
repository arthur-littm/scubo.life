class ScuboPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def new?
    user
  end

  def create?
  end

  def edit?
  end

  def update?
  end
end
