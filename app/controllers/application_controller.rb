class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def set_categories
    @categories = policy_scope(Category)
  end

  def set_hashtags
    @hashtags = policy_scope(Hashtag)
      .left_joins(:items)
      .group(:id)
      .order('COUNT(items.id) DESC')
      .limit(5)
  end

  def set_cities
    @cities = policy_scope(City)
      .left_joins(:items)
      .group(:id)
      .order('COUNT(items.id) DESC')
      .limit(5)
  end


  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

end
