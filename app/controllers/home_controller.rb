class HomeController < ApplicationController
  def index
    typeParam = params[:posttype].try(:downcase)
    if !typeParam.present?
        typeParam = 'all'
    end

    sortParam = params[:sort].try(:downcase)
    if !sortParam.present?
        sortParam = 'recent'
    end

    sort = :updated_at
    case sortParam
    when 'recent'
        sort = :updated_at
    when 'popularity'
        sort = :view_count
    end

    category = params[:c].try(:downcase)
    if category.present?
      case typeParam
      when 'all'
          @posts = Guide.tagged_with(category).order(sort => :asc).reverse +
              Event.tagged_with(category).order(sort => :asc).reverse +
              Help.tagged_with(category).order(sort => :asc).reverse
          @posts = @posts.sort_by{|e| e[sort]}.reverse
      when 'guides'
          @posts = Guide.tagged_with(category).order(sort => :asc).reverse
      when 'events'
          @posts = Event.tagged_with(category).order(sort => :asc).reverse
      when 'helps'
          @posts = Help.tagged_with(category).order(sort => :asc).reverse
      end
    else
      case typeParam
      when 'all'
          @posts = Guide.order(sort => :asc).reverse +
              Event.order(sort => :asc).reverse +
              Help.order(sort => :asc).reverse
          @posts = @posts.sort_by{|e| e[sort]}.reverse
      when 'guides'
          @posts = Guide.order(sort => :asc).reverse
      when 'events'
          @posts = Event.order(sort => :asc).reverse
      when 'helps'
          @posts = Help.order(sort => :asc).reverse
      end
    end

    @posts = @posts.paginate(:page => params[:page], :per_page => 8)

    @recentPosts = Guide.order(sort => :asc).reverse +
              Event.order(sort => :asc).reverse +
              Help.order(sort => :asc).reverse

    # @recentPosts = @recentPosts.sort_by{|e| e.impressions[:created_at]}.reverse
    @recentPosts = @recentPosts.first(6)
  end
end
