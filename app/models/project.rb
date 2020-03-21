class Project < ApplicationRecord
  belongs_to :user

  include PgSearch::Model

  has_many :volunteers, dependent: :destroy
  has_many :volunteered_users, through: :volunteers, source: :user, dependent: :destroy

  acts_as_taggable_on :skills
  acts_as_taggable_on :project_types

  pg_search_scope :search, against: %i(name description participants looking_for location highlight), using: { tsearch: { any_word: true } }

  def to_param
    [id, name.parameterize].join("-")
  end

  def volunteer_emails
    self.volunteered_users.collect { |u| u.email }
  end
end
