class CreatePostsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: true
      t.text :links, null: true
      t.text :project_ids, null: true

      t.timestamps
    end
  end
end
