class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :cover_image, styles: { med: "400x150", large: "800x300" }, :default_url => "/images/:style/missing.jpg"
  validates_attachment_content_type :cover_image, :content_type => [/\Aimage/, 'application/octet-stream']
  # Validate filename
  validates_attachment_file_name :cover_image, matches: [/png\Z/, /jpe?g\Z/]
  # Explicitly do not validate
  do_not_validate_attachment_file_type :cover_image

  has_attached_file :picture, styles: { small: "64x64", med: "100x100", large: "200x200" }, :default_url => "/images/:style/missing.jpg"
  validates_attachment_content_type :picture, :content_type => [/\Aimage/, 'application/octet-stream']
  # Validate filename
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]
  # Explicitly do not validate
  do_not_validate_attachment_file_type :picture
end
