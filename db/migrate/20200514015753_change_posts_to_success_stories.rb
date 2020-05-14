class ChangePostsToSuccessStories < ActiveRecord::Migration[6.0]
  def change
    rename_table :posts, :success_stories

  end
end
