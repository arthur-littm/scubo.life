class UpvotesController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    authorize item
    Upvote.create(item: item, user: current_user)
    redirect_to root_path
  end

  def destroy
  end
end
