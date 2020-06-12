class UsersController < ApplicationController
  before_action :set_user

  def my_account
  end

  def saved
  end

  def pending
  end

  def archive
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = current_user
    authorize @user
  end
end
