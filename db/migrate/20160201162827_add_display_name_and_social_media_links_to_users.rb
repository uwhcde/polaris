class AddDisplayNameAndSocialMediaLinksToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string
    add_column :users, :social_media_1, :string
    add_column :users, :social_media_2, :string
    add_column :users, :social_media_3, :string
    add_column :users, :social_media_4, :string
  end
end
