class HomeController < ApplicationController
  def index
    @guides = Guide.last(5).reverse
    @events = Event.last(5).reverse
    @helps = Help.last(5).reverse
    @posts = []
    @guides.each_with_index do |guide, index|
      @posts.push({date: guide.created_at, value: guide})
    end
    @events.each_with_index do |event, index|
      @posts.push({date: event.created_at, value: event})
    end
    @helps.each_with_index do |help, index|
      @posts.push({date: help.created_at, value: help})
    end

    @posts.sort_by{|e| e[:date]}

  end
end
