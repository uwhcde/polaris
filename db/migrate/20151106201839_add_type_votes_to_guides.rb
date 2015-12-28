class AddTypeVotesToGuides < ActiveRecord::Migration
  def change
    add_column :guides, :upVotes, :integer, :default => 0
    add_column :guides, :downVotes, :integer, :default => 0
  end
end
