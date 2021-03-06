class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :url  => "/uploads/pictures/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/uploads/pictures/:id/:style_:basename.:extension",
                    :styles => { :content => '800>', :thumb => '118x100#' }

  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_content_type :data, :content_type => /\Aimage/

  belongs_to :guide, class_name: "Guide"

  def url_content
    url(:content)
  end
end
