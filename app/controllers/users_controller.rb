class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    guides = Guide.last(5).reverse
    events = Event.last(5).reverse
    helps = Help.last(5).reverse

    @posts = {
        "all" => (guides+events+helps).shuffle,
        "guides" => guides,
        "events" => events,
        "helps" => helps
    }
  end
end
