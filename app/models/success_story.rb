class SuccessStory < ApplicationRecord
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
end
