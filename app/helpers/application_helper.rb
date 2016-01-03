module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end

end
