class SearchController < ApplicationController

  def index
    @search = Sunspot.search Guide, Event, Help do
      fulltext params[:q]
    end
    @posts = @search.results
  end

end

