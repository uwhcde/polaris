class RenameStepToSection < ActiveRecord::Migration
  def change
    rename_table :steps, :sections
  end
end
