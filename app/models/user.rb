class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects
  has_many :volunteers
  has_many :volunteered_projects, through: :volunteers, source: :project, dependent: :destroy

  def volunteered_for_project? project
    self.volunteered_projects.where(id: project.id).exists?
  end

  def has_complete_profile?
    self.about.present? && self.profile_links.present? && self.location.present?
  end

  def is_visible_to_user?(user)
    return true if self.visibility == true
    return true if user == self

    user_volunteered_to_own_projects = user.volunteered_projects.where(user_id: self.id).exists?
    return true if user_volunteered_to_own_projects

    false
  end
end
