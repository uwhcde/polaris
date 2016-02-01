class Event < ActiveRecord::Base

  belongs_to :user
  belongs_to :picture, class_name: "Ckeditor::Picture"


  acts_as_taggable
  acts_as_taggable_on :tag_list

  acts_as_votable
  acts_as_commentable

  validates :title, presence: true
  validates :description, presence: true

  private

end
