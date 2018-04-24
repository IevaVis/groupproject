class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_table :users do |t|
  		t.integer :role
 		t.string :first_name
 		t.string :last_name
 		t.text :about_me, array: true, default: []
		end
  end
end
