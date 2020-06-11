class UsersController < ApplicationController
  def my_account
    @user = current_user
    authorize @user
  end
end
