class Section < ActiveRecord::Base

  belongs_to :post, touch: true
end
