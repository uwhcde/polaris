class AddShowEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_email, :boolean, default: true
  end
end
