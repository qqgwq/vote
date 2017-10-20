class Admin::TopicsController < ApplicationController
  layout "admin"
  before_action :required_admin

  def new
    @topic = Topic.new
  end

  def index
    @topics = Topic.all
  end

  def create
   @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to @topic
    else
      render 'new'
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :title, :school, :avatar, :content)
  end
end
