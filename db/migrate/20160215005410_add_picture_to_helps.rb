class AddPictureToHelps < ActiveRecord::Migration
  def change
    add_column :helps, :picture_id, :integer
  end
end
