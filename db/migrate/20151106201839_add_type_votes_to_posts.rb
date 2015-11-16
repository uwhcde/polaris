class AddTypeVotesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :postType, :string
    add_column :posts, :upVotes, :integer, :default => 0
    add_column :posts, :downVotes, :integer, :default => 0
  end
end
