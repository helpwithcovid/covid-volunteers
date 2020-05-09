class Post < ApplicationRecord
  include HasCoverPhoto

  def to_param
    [id, title.parameterize].join('-')
  end

  def projects
    return if project_ids.blank?

    begin
      Project.where id: project_ids.split(',').map(&:strip)
    end
  end

  def cover_photo(category_override = nil)
    Rails.cache.fetch(cdn_image_cache_key, expires_in: 1.month) do
      if self.image.present?
        cdn_variant
      else
        "/images/project-default.png"
      end
    end
  end
end
