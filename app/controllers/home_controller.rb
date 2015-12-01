class HomeController < ApplicationController
  def index
    @guides = Guide.last(5).reverse
    @events = Event.last(5).reverse
    @helps = Help.last(5).reverse
    @entries = []
    @guides.each_with_index do |guide, index|
      @entries.push({date: guide.created_at, value: guide})
    end
    @events.each_with_index do |event, index|
      @entries.push({date: event.created_at, value: event})
    end
    @helps.each_with_index do |help, index|
      @entries.push({date: help.created_at, value: help})
    end

    @entries.sort_by{|e| e[:date]}

  end
end
