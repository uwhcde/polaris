class Guide < ActiveRecord::Base

  has_many :sections, inverse_of: :guide, dependent: :destroy

  belongs_to :user
  belongs_to :picture, class_name: "Ckeditor::Picture"


  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true
  acts_as_taggable
  acts_as_taggable_on :tag_list

  acts_as_votable
  acts_as_commentable

  validates :title, presence: true
  validates :short_description, presence: true

  has_reputation :bookmark,
      :source => :user

  private

end
