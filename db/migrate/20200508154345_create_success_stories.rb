class CreateSuccessStories < ActiveRecord::Migration[6.0]
  def change
    create_table :success_stories do |t|
      t.string :title, null: false
      t.text :body, null: true
      t.text :links, null: true

      t.timestamps
    end

    create_table :sucess_stories_projects do |t|
      t.belongs_to :success_story
      t.belongs_to :project
    end
  end
end
