class AddFieldToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :slack_url, :string, null: true, default: ""
    add_column :projects, :discord_url, :string, null: true, default: ""
    add_column :projects, :github_url, :string, null: true, default: ""
    add_column :projects, :social_media_links, :string, null: true, default: ""
  end
end
