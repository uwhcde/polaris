class Post < ActiveRecord::Base
  has_many :comments
  has_many :sections, inverse_of: :post, dependent: :destroy
  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true
  before_save :init

  private
    def init
      self.upVotes ||= 0
      self.downVotes ||= 0
      self.postType ||= "Guide"
    end
end
