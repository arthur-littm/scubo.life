class UserPolicy < ApplicationPolicy
  def my_account?
    current_user_is_owner?
  end

  def pending?
    current_user_is_owner?
  end

  def saved?
    current_user_is_owner?
  end

  def archive?
    current_user_is_owner?
  end

  private

  def current_user_is_owner?
    record == user
  end
end
