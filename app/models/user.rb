require 'csv'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  has_many :volunteers, dependent: :destroy
  has_many :volunteered_projects, through: :volunteers, source: :project, dependent: :destroy

  has_many :offers
  acts_as_taggable_on :skills

  def volunteered_for_project? project
    self.volunteered_projects.where(id: project.id).exists?
  end

  def has_complete_profile?
    self.about.present? && self.profile_links.present? && self.location.present?
  end

  def is_visible_to_user?(user)
    return true if self.visibility == true
    return false if user.blank?
    return true if user == self

    user_volunteered_to_self_projects = user.volunteered_projects.where(user_id: self.id).exists?
    return true if user_volunteered_to_self_projects

    false
  end

  def is_admin?
    ADMINS.include?(self.email)
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
end
