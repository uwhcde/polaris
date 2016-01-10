class Help < ActiveRecord::Base

  belongs_to :user

  acts_as_taggable
  acts_as_taggable_on :tag_list

  acts_as_votable
  acts_as_commentable

end
