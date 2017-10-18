class LikesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @like = @topic.likes.where(user_id: current_user.id).first_or_create
    current_user.ranks.incr(current_user.id, 1)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @topic.likes.where(user_id: current_user.id).delete_all
    current_user.ranks.decr(current_user.id, 1)
    respond_to do |format|
      format.js
    end
  end
end
