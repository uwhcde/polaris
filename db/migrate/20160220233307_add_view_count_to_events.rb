class AddViewCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :view_count, :integer, :default => 0
  end
end
