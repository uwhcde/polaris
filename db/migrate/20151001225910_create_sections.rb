# Migration file to create sections table
class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|

      t.string   "title"
      t.text     "description"
      t.integer  "position"
      t.integer  "guide_id", null: false
      t.integer  "user_id", null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
