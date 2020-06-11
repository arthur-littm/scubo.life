class UserPolicy < ApplicationPolicy
  def my_account?
    current_user_is_owner?
  end

  private

  def current_user_is_owner?
    record == user
  end
end
