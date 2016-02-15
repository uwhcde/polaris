class MycardsController < ApplicationController

  # load_and_authorize_resource


  def index
    @posts = Guide.evaluated_by(:bookmark, current_user)
    @posts.push(Event.evaluated_by(:bookmark, current_user))
    @posts.push(Help.evaluated_by(:bookmark, current_user))
  end

end
