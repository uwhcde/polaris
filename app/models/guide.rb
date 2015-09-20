class Guide < ActiveRecord::Base
  has_many :comments
  has_many :sections, inverse_of: :guide, dependent: :destroy
  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true
  before_save :init

  belongs_to :user
  belongs_to :picture, class_name: "Ckeditor::Picture"


  # has_attached_file :cover, styles: { med: "400x150", large: "800x300" }, :default_url => ":style/missing.jpg"
  # validates_attachment_content_type :cover, :content_type => [/\Aimage/, 'application/octet-stream']
  # # Validate filename
  # # validates_attachment_file_name :cover, matches: [/png\Z/, /jpe?g\Z/]
  # # Explicitly do not validate
  # do_not_validate_attachment_file_type :cover

  validates :title, presence: true
  validates :short_description, presence: true

  private
    def init
      self.upVotes ||= 0
      self.downVotes ||= 0
    end
end
