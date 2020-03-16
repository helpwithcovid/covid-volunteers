class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects
  has_many :liked_projects, through: :like

  def liked_project? project
    current_user.liked_projects.where(id: project.id).exists?
  end
end
