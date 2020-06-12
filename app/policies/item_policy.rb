class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.published_items
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def can_upvote?
    user && !record.upvoters.include?(user)
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
    current_user_is_owner?
  end

  def update?
    current_user_is_owner?
  end

  private

  def current_user_is_owner?
    record.user == user
  end
end
