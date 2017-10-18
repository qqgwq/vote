class TopicsController < ApplicationController
  before_action :required_login, only: [:new, :create, :show, :edit, :update, :destroy]
  def new
    @topic = Topic.new
  end

  def index
    #binding.pry
    @topics = Topic.all
    @users = User.order("field(id, #{User.ranks.members.join(',')})")
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to @topic
    else
      render 'new'
    end
  end

  def show
    @topic = Topic.find(params[:id])
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :content)
  end
end
