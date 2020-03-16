class Project < ApplicationRecord
  belongs_to :user

  has_many :volunteers, dependent: :destroy
  has_many :volunteered_users, through: :volunteers, source: :user, dependent: :destroy
end
