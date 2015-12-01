class Section < ActiveRecord::Base

  belongs_to :guide, touch: true
end
