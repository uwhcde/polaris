# Migration file to create guides table
class CreateGuides < ActiveRecord::Migration
  def self.up
    create_table :guides do |t|
      t.string :title
      t.text :short_description
      t.integer :user_id, null: false
      t.text :tagging_details
      t.time :publish_date
      t.integer :picture_id, null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :guides
  end
end
