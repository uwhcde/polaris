class MycardsController < ApplicationController

  # load_and_authorize_resource


  def index
    @guides = Guide.evaluated_by(:bookmark, current_user)
    @events = Event.evaluated_by(:bookmark, current_user)
    @helps = Help.evaluated_by(:bookmark, current_user)

    @posts = @guides + @events + @helps

  end

end
