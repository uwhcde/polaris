class AddPostIdToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :post_id, :integer, null: false
  end
end
