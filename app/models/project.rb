class Project < ApplicationRecord
  belongs_to :user

  include PgSearch::Model

  validates :name, presence: true
  validates :short_description, length: { maximum: 129 }
  
  has_many :volunteers, dependent: :destroy
  has_many :volunteered_users, through: :volunteers, source: :user, dependent: :destroy

  acts_as_taggable_on :skills
  acts_as_taggable_on :project_types

  pg_search_scope :search, against: %i(name description participants looking_for location highlight)

  after_save do
    # expire homepage caches if they contain this project
    Settings.project_groups.each do |group|
      cache_key = "project_group_#{group[:name].downcase}_featured_projects"
      featured_projects = Rails.cache.read cache_key

      next if featured_projects.blank?

      Rails.cache.delete(cache_key) if featured_projects.map(&:id).include? self.id
    end
  end

  # This would be awesome but we have a bunch of sites with no statuses right now.
  # validates :status, inclusion: { in: ALL_PROJECT_STATUS }

  def to_param
    [id, name.parameterize].join("-")
  end

  def volunteer_emails
    self.volunteered_users.collect { |u| u.email }
  end

  def volunteered_users_count
    volunteered_users.count
  end

  def serializable_hash(options={})
    super(
      only: [
        :id,
        :name,
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
        :accepting_volunteers,
        :created_at,
        :updated_at,
        :status,
        :short_description
      ],
      methods: [:to_param, :volunteered_users_count, :project_type_list, :skill_list]
    )
  end

  def group
    project_groups = {}

    begin
      Settings.project_groups.each do |group|
        intersection = self.project_type_list.to_a & group['project_types'].to_a
        project_groups[group.name] = intersection.count
      end

      present_group = project_groups.sort_by { |k, v| v }.reverse.first.first
    end

    present_group
  end

  def cover_photo(group_override = nil)
    cover_photo = false
    if cover_photo.present?
    else
      "/images/#{group_override.blank? ? self.group.downcase : group_override.downcase}-default.jpg"
    end
  end

  include AlgoliaSearch

  algoliasearch per_environment: true do
    attribute :name, :description, :participants, :goal, :looking_for, :location, :contact, :highlight, :progress, :docs_and_demo, :volunteered_users_count, :project_type_list, :skill_list

    attribute :created_at do
      created_at.to_i
    end

    attribute :updated_at do
      updated_at.to_i
    end

    attribute :objectID do
      :id
    end

    add_attribute :number_of_volunteers_needed do
      number_of_volunteers
    end

  end  

end
