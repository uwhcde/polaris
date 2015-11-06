class Post < ActiveRecord::Base

  has_many :sections, inverse_of: :post, dependent: :destroy
  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true
end
