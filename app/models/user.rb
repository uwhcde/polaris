class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :guides
  has_many :events
  has_many :helps

  has_attached_file :cover_image,
    styles: { medium: "400x150", large: "800x300" },
    url: "/uploads/profile/cover/:id/:style_:basename.:extension",
    default_url: ':user_cover'

  validates_attachment_content_type :cover_image, :content_type => [/\Aimage/, 'application/octet-stream']
  # Validate filename
  validates_attachment_file_name :cover_image, matches: [/png\Z/, /jpe?g\Z/]
  # Explicitly do not validate
  do_not_validate_attachment_file_type :cover_image

  has_attached_file :picture,
    styles: { small: "64x64", medium: "100x100", large: "200x200" },
    default_url: ':user_avatar',
    url: "/uploads/profile/avatar/:id/:style_:basename.:extension"

  validates_attachment_content_type :picture, :content_type => [/\Aimage/, 'application/octet-stream']
  # Validate filename
  validates_attachment_file_name :picture, matches: [/png\Z/, /jpe?g\Z/]
  # Explicitly do not validate
  do_not_validate_attachment_file_type :picture

  def full_name
    "#{first_name} #{last_name}".strip
  end

end
