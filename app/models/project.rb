class Project < ApplicationRecord
  belongs_to :user

  has_many :volunteers, dependent: :destroy
  has_many :volunteered_users, through: :volunteers, source: :user, dependent: :destroy

  acts_as_taggable_on :skills
  acts_as_taggable_on :project_types

  def volunteer_emails
    self.volunteered_users.collect { |u| u.email }
  end
end
