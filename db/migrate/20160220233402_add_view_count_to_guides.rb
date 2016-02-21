class AddViewCountToGuides < ActiveRecord::Migration
  def change
    add_column :guides, :view_count, :integer, :default => 0
  end
end
