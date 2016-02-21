class AddViewCountToHelps < ActiveRecord::Migration
  def change
    add_column :helps, :view_count, :integer, :default => 0
  end
end
