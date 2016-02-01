class AddPicIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :picture_id, :integer
  end
end
