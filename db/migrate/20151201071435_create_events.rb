class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :from
      t.date :to
      t.integer :user_id
      t.string :location
      t.float :longitude
      t.float :latitude
      t.string :hostedby
      t.text :description
      t.float :intereted
      t.integer :going
      t.integer :invited
      t.string :cover

      t.timestamps null: false
    end
  end
end
