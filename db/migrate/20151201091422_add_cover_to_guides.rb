class AddCoverToGuides < ActiveRecord::Migration
  def change
    add_column :guides, :cover, :string
  end
end
