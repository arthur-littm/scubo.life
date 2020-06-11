class UpvotesController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    upvote = Upvote.create(item: item, user: current_user)
    authorize upvote
    redirect_to root_path
  end

  def destroy
    upvote = Upvote.find(params[:id])
    authorize upvote
    upvote.destroy
    redirect_to root_path
  end
end
