class AddTypeVotesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :postType, :string
    add_column :posts, :upVotes, :integer, 0
    add_column :posts, :downVotes, :integer, 0
  end
end
