Paperclip.options[:content_type_mappings] = { jpeg: 'image/jpeg', jpg: "image/jpeg" }


# config/initializers/paperclip.rb
Paperclip.interpolates(:user_avatar) do |attachment, style|
  ActionController::Base.helpers.asset_path("users/avatar/missing_#{style}.jpg")
end

Paperclip.interpolates(:user_cover) do |attachment, style|
  ActionController::Base.helpers.asset_path("users/cover/missing_#{style}.jpg")
end

