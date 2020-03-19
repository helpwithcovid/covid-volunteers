class Project < ApplicationRecord
  include PgSearch::Model
  belongs_to :user

  has_many :volunteers, dependent: :destroy
  has_many :volunteered_users, through: :volunteers, source: :user, dependent: :destroy

  acts_as_taggable_on :skills
  acts_as_taggable_on :project_types

  pg_search_scope :skill_search, associated_against: {
    skills: [:name]
  }

  pg_search_scope :project_type_search, associated_against: {
    project_types: [:name]
  }

  def volunteer_emails
    self.volunteered_users.collect { |u| u.email }
  end
end
