class HashtagsController < ApplicationController
  def index
    if params[:query].present?
      sql_query = "name ILIKE :query"
      @hashtags = policy_scope(Hashtag).where(sql_query, query: "%#{params[:query]}%").includes(:items)
    else
      @hashtags = policy_scope(Hashtag).includes(:items)
    end
    @hashtags = @hashtags.sort_by { |h| h.items.count }.first(5)
    respond_to do |format|
      format.json { render json: @hashtags.map { |h| { name: h.name, count: h.items.count } } }
    end
  end
end
