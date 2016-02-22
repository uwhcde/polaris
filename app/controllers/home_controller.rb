class HomeController < ApplicationController
  def index
    @posts = []
    @guides = []
    @events = []
    @helps = []

    sort = :created_at

    category = params[:c].try(:downcase)
    if category.present?
      if Polaris::Constants::Categories::DEFAULT.include?(category)
        @posts = Guide.tagged_with(category).order(sort => :asc).last(5).reverse +
          Event.tagged_with(category).order(sort => :asc).last(5).reverse +
          Help.tagged_with(category).order(sort => :asc).last(5).reverse
      end
    else
      @posts = Guide.order(sort => :asc).last(10).reverse +
        Event.order(sort => :asc).last(10).reverse +
        Help.order(sort => :asc).last(10).reverse
    end

    @posts = @posts.sort_by{|e| e[sort]}.reverse
  end
end
