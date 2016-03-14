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

    @params = {"posttype" => params[:posttype],
    "sort" => params[:sort],
    "c" => params[:c]}

    if !@posts.nil?
      @posts = @posts.paginate(:page => params[:page], :per_page => 8)
    end

    if current_user
      @recentPosts = []
      @recent_impressions = Impression.where(:user_id => current_user.id).order("created_at DESC").limit(20)
      @recent_impressions.each do |d|
        @recentPosts.push d.impressionable_type.classify.constantize.find(d.impressionable_id)
      end
    end

  end
end
