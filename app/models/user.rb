class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects
  has_many :likes
  has_many :liked_projects, through: :likes, source: :project

  def liked_project? project
    self.liked_projects.where(id: project.id).exists?
  end
end
