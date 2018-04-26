class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :article, index: true
      t.text :text
      t.timestamps
    end
  end
end
