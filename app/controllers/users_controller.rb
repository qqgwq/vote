class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.search(params[:search]).order(created_at: :desc)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_as @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :image)
  end
end
