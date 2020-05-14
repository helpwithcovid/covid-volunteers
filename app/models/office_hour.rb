class OfficeHour < ApplicationRecord
  belongs_to :user
  belongs_to :participant, foreign_key: 'participant_id', class_name: 'User', optional: true

  def can_edit?(edit_user)
    edit_user && (self.user == edit_user || edit_user.is_admin?)
  end

  def applied?(user)
    return false if user.blank?

    self.applications.each do |application|
      return true if user == application
    end
    false
  end

  def applications
    User.where(id: self.application_user_ids).all
  end

  def applications_with_projects_json
    self.applications.to_json(only: [ :id, :name, :email ],
      include: { projects: { only: [ :id, :title ] } })
  end

  def participant_json
    return {}.to_json if self.participant.blank?
    self.participant.to_json(only: [ :id, :name, :email ])
  end
end
