class TopicsController < ApplicationController
  before_action :required_login, only: [:new, :create, :show, :edit, :update, :destroy]
  def new
    @topic = Topic.new
  end

  def index
    #用户根据id排名
    @topics = Topic.search(params[:search]).order("field(id, #{Topic.ranks.members.reverse.join(',')})").limit(50)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def all
    @topics = Topic.all
  end

  def like
    @topic = Topic.find(params[:id])
    @topic.ranks.incr(@topic.id, 1)#当前用户点赞加1
    @topic.vote << current_user.id #把当前用户赋值给集合，判断用户是否点赞
      respond_to do |format|
        format.js
      end
  end

  # def unlike
  #   @topic = Topic.find(params[:id])
  #   @topic.ranks.decr(@topic.id, 1)
  #     respond_to do |format|
  #       format.js
  #     end
  # end
end
