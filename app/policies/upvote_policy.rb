class UpvotePolicy < ApplicationPolicy
  def destroy?
    current_user_is_owner?
  end

  def create?
    current_user_is_owner?
  end

  private

  def current_user_is_owner?
    record.user == user
  end
end
