class HomeController < ApplicationController
  def index
    @posts = Post.last(5).reverse
    @events = Event.last(5).reverse
    @entries = []
    @posts.each_with_index do |post, index|
      @entries.push({date: post.created_at, value: post})
    end
    @events.each_with_index do |event, index|
      @entries.push({date: event.created_at, value: event})
    end

    @entries.sort_by{|e| e[:date]}

  end
end
