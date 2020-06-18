class Project < ApplicationRecord
  belongs_to :user

  include PgSearch::Model

  has_many :volunteers, dependent: :destroy
  has_many :volunteered_users, through: :volunteers, source: :user, dependent: :destroy

  acts_as_taggable_on :skills
  acts_as_taggable_on :project_types
  acts_as_taggable_on :vols

  pg_search_scope :search, against: %i(name description participants looking_for location highlight)

  validates_presence_of :project_type_list, allow_nil: false, allow_blank: false

  def to_param
    [id, name.parameterize].join("-")
  end

  def volunteer_emails
    self.volunteered_users.collect { |u| u.email }
  end

  def volunteer_names
    self.volunteered_users.collect { |u| u.name }
  end

  def volunteered_users_count
    volunteered_users.count
  end

  def is_visible_to_user?(user_trying_view)
    return true if self.visible == true
    return true if user_trying_view && user_trying_view.is_admin?
    return true if user_trying_view == self.user
    false
  end

  def serializable_hash(options={})
    super(
      only: [
        :id,
        :name,
        :organization,
        :level_of_urgency,
        :description,
        :participants,
        :goal,
        :looking_for,
        :location,
        :contact,
        :highlight,
        :progress,
        :docs_and_demo,
        :number_of_volunteers,
        :visible,
        :created_at,
        :updated_at
      ],
      methods: [:to_param, :volunteered_users_count, :project_type_list, :skill_list, :vol_list, :visible]
    )
  end
end
