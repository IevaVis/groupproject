class AddTitleRemoveAboutmeFromUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :title, :string
  	remove_column :users, :about_me, array: true, default: []
  end
end
