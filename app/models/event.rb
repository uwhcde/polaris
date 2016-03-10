class Event < ActiveRecord::Base

  belongs_to :user
  belongs_to :picture, class_name: "Ckeditor::Picture"

  has_many :impressions

  acts_as_taggable
  acts_as_taggable_on :tag_list

  acts_as_votable
  acts_as_commentable

  validates :title, presence: true
  validates :description, presence: true

  has_reputation :bookmark,
    :source => :user

  has_reputation :rsvp,
    :source => :user

  is_impressionable :counter_cache => true, :column_name => :view_count, :unique => :request_hash

  private

end
