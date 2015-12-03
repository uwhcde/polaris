class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    @guides = Guide.last(5).reverse
    @events = Event.last(5).reverse
    @helps = Help.last(5).reverse
  end
end
