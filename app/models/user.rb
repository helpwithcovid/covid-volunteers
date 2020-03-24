require 'csv'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include PgSearch::Model

  has_many :projects, dependent: :destroy
  has_many :volunteers, dependent: :destroy
  has_many :volunteered_projects, through: :volunteers, source: :project, dependent: :destroy

  has_many :offers
  acts_as_taggable_on :skills

  pg_search_scope :search, against: %i(name email about location level_of_availability)

  def volunteered_for_project? project
    self.volunteered_projects.where(id: project.id).exists?
  end

  def has_complete_profile?
    self.about.present? && self.profile_links.present? && self.location.present?
  end

  def is_visible_to_user?(user_trying_view)
    return true if self.visibility == true
    return false if user_trying_view.blank?
    return true if user_trying_view == self

    # Check if this user volunteered for any project by user_trying_view.
    return self.volunteered_projects.where(user_id: user_trying_view.id).exists?
  end

  def is_admin?
    ADMINS.include?(self.email)
  end

  def to_param
    [id, name.parameterize].join("-")
  end

  def self.to_csv
    attributes = %w{email about profile_links location level_of_availability}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.find_each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def active_for_authentication?
    super && !self.deactivated
  end
end
