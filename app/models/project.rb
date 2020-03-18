class Project < ApplicationRecord
  include PgSearch::Model
  belongs_to :user

  has_many :volunteers, dependent: :destroy
  has_many :volunteered_users, through: :volunteers, source: :user, dependent: :destroy

  acts_as_taggable_on :skills

  def volunteer_emails
    self.volunteered_users.collect { |u| u.email }
  end
end
