class Help < ActiveRecord::Base

  acts_as_taggable
  acts_as_taggable_on :tag_list
end
