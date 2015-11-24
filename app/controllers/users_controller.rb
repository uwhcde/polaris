class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @guides = Post.all
    @helps = Post.all
    @events = Post.all
  end
end
