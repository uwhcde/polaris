class Guide < ActiveRecord::Base

  before_save :init

  has_many :comments
  has_many :sections, inverse_of: :guide, dependent: :destroy

  belongs_to :user
  belongs_to :picture, class_name: "Ckeditor::Picture"



  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true
  acts_as_taggable
  acts_as_taggable_on :tag_list


  validates :title, presence: true
  validates :short_description, presence: true

  private
    def init
      self.upVotes ||= 0
      self.downVotes ||= 0
    end
end
