class UsersController < ApplicationController
  def show
    typeParam = params[:type].try(:downcase)
    if !typeParam.present?
        typeParam = 'all'
    end

    sortParam = params[:sort].try(:downcase)
    if !sortParam.present?
        sortParam = :created_at
    end

    sort = :created_at
    case sortParam
    when '1'
        sort = :created_at
    when '2'
        sort = :view_count
    end

    case typeParam
    when 'all'
        posts = Guide.where(:user_id => current_user.id).order(sort => :asc).last(5).reverse +
            Event.where(:user_id => current_user.id).order(sort => :asc).last(5).reverse +
            Help.where(:user_id => current_user.id).order(sort => :asc).last(5).reverse
        posts = posts.sort_by{|e| e[sort]}.reverse.first(5)
    when 'guides'
        posts = Guide.where(:user_id => current_user.id).order(sort => :asc).last(5).reverse
    when 'events'
        posts = Event.where(:user_id => current_user.id).order(sort => :asc).last(5).reverse
    when 'helps'
        posts = Help.where(:user_id => current_user.id).order(sort => :asc).last(5).reverse
    end

    @user = User.find(params[:id])

    @posts = {
        "all" => posts,
        "guides" => posts,
        "events" => posts,
        "helps" => posts
    }
  end
end
