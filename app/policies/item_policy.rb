class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def map?
    true
  end

  def new?
    user
  end

  def create?
    user
  end

  def edit?
  end

  def update?
  end
end
