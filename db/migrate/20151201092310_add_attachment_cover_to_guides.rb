class AddAttachmentCoverToGuides < ActiveRecord::Migration
  def self.up
    change_table :guides do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :guides, :cover
  end
end
