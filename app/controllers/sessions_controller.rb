class SessionsController < ApplicationController
  def new
  end

  def create
    #binding.pry
    @user = User.find_by(name: params[:login])
    if @user && @user.authenticate(params[:password])
      login_as @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  private

  def login_params
    params.require(:session).permit(:login, :password)
  end
end
