class AddHelpTypeToHelps < ActiveRecord::Migration
  def change
    add_column :helps, :help_type, :string
  end
end
