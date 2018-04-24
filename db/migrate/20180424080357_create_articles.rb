class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :link
      t.string :tags, array: true
      t.boolean :is_active
      t.timestamps
    end
  end
end
