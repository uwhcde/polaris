class CreateHelps < ActiveRecord::Migration
  def change
    create_table :helps do |t|
      t.string :title
      t.integer :user_id
      t.string :location
      t.float :longitude
      t.float :latitude
      t.integer :requiredby
      t.text :description
      t.string :cover
      t.date :date

      t.timestamps null: false
    end
  end
end
