class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def following
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
  end
end
