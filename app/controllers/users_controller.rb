require 'will_paginate/array'

class UsersController < ApplicationController
  def show
    typeParam = params[:posttype].try(:downcase)
    if !typeParam.present?
        typeParam = 'all'
    end

    sortParam = params[:sort].try(:downcase)
    if !sortParam.present?
        sortParam = 'recent'
    end

    sort = :created_at
    case sortParam
    when 'recent'
        sort = :created_at
    when 'popularity'
        sort = :view_count
    end

    case typeParam
    when 'all'
        @posts = Guide.where(:user_id => current_user.id).order(sort => :asc).reverse +
            Event.where(:user_id => current_user.id).order(sort => :asc).reverse +
            Help.where(:user_id => current_user.id).order(sort => :asc).reverse
        @posts = @posts.sort_by{|e| e[sort]}.reverse
    when 'guides'
        @posts = Guide.where(:user_id => current_user.id).order(sort => :asc).reverse
    when 'events'
        @posts = Event.where(:user_id => current_user.id).order(sort => :asc).reverse
    when 'helps'
        @posts = Help.where(:user_id => current_user.id).order(sort => :asc).reverse
    end

    @user = User.find(params[:id])

    @posts = @posts.paginate(:page => params[:page], :per_page => 3)

  end
end
