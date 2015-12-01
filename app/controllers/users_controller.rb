class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @guides = Guide.all
    @helps = Guide.all
    @events = Guide.all
  end
end
