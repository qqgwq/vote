class TopicsController < ApplicationController
  before_action :required_login, only: [:new, :create, :show, :edit, :update, :destroy]
  def new
    @topic = Topic.new
  end

  def index
    #binding.pry
    @topics = Topic.order("field(id, #{Topic.ranks.members.reverse.join(',')})").limit(50)
  end

  def show
    @topic = Topic.find(params[:id])
    if current_user
      #binding.pry
      if @topic.vote.member?(current_user.id) #判断用户是否已给文章投票
        @topic.ranks.incr(@topic.id)&.next 
        @topic.vote << current_user.id
      end
    end
  end

  def all
    @topics = Topic.all
  end

  def like
    @topic = Topic.find(params[:id])
    @topic.ranks.incr(@topic.id, 1)
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
