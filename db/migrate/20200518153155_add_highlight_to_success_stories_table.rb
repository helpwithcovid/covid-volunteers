class AddHighlightToSuccessStoriesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :success_stories, :highlight, :boolean, null: false, default: false
  end
end
