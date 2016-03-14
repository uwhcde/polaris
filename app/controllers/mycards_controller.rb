class MycardsController < ApplicationController

  # load_and_authorize_resource


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
      case category
      when 'all'
          @posts = Guide.evaluated_by(:bookmark, current_user).order(sort => :asc).reverse +
              Event.evaluated_by(:bookmark, current_user).order(sort => :asc).reverse +
              Help.evaluated_by(:bookmark, current_user).order(sort => :asc).reverse +
              Event.evaluated_by(:rsvp, current_user).order(sort => :asc).reverse
          @posts = @posts.sort_by{|e| e[sort]}.reverse
      when 'rsvp'
          @posts = Event.evaluated_by(:rsvp, current_user).order(sort => :asc).reverse
      when 'helps'
          @posts = Help.tagged_with(category).order(sort => :asc).reverse
      end
    else
      @posts = Guide.evaluated_by(:bookmark, current_user).order(sort => :asc).reverse +
              Event.evaluated_by(:bookmark, current_user).order(sort => :asc).reverse +
              Help.evaluated_by(:bookmark, current_user).order(sort => :asc).reverse +
              Event.evaluated_by(:rsvp, current_user).order(sort => :asc).reverse
          @posts = @posts.sort_by{|e| e[sort]}.reverse
    end

    @params = {"posttype" => params[:posttype],
      "sort" => params[:sort],
      "c" => params[:c]}

    if !@posts.nil?
      @posts = @posts.paginate(:page => params[:page], :per_page => 8)
    end


  end

end
