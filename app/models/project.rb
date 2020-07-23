class Project < ApplicationRecord
  include HasCoverPhoto
  include PgSearch::Model

  belongs_to :user

  validates :name, presence: true
  validates :short_description, length: { maximum: 129 }

  has_many :volunteers, dependent: :destroy
  has_many :volunteered_users, through: :volunteers, source: :user, dependent: :destroy

  acts_as_taggable_on :skills
  acts_as_taggable_on :project_types

  pg_search_scope :search, against: %i(name description participants looking_for volunteer_location target_country target_location highlight)

  after_save do
    # expire homepage caches if they contain this project
    Settings.project_categories.each do |category|
      cache_key = "project_category_#{category[:name].downcase}_featured_projects"
      featured_projects = Rails.cache.read cache_key

      next if featured_projects.blank?

      Rails.cache.delete(cache_key) if featured_projects.map(&:id).include? self.id
    end
  end

  validates :status, inclusion: { in: Settings.project_statuses }

  before_validation :default_values

  def default_values
    self.status = Settings.project_statuses.first if self.status.blank?
  end

  def to_param
    [id, name.parameterize].join('-')
  end

  def can_edit?(edit_user)
    edit_user && (self.user == edit_user || edit_user.is_admin?)
  end

  def volunteer_emails
    self.volunteered_users.collect { |u| u.email }
  end

  def volunteered_users_count
    volunteered_users.count
  end

  def serializable_hash(options = {})
    super(
      only: [
        :id,
        :name,
        :description,
        :participants,
        :goal,
        :looking_for,
        :volunteer_location,
        :target_country,
        :target_location,
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

  def category
    project_categories = {}

    begin
      Settings.project_categories.each do |category|
        intersection = self.project_type_list.to_a & category['project_types'].to_a
        project_categories[category.name] = intersection.count
      end

      present_category = project_categories.sort_by { |k, v| v }.reverse.first.first
    end

    present_category
  end

  def cover_photo(category_override = nil)
    Rails.cache.fetch(cdn_image_cache_key, expires_in: 1.month) do

      if self.image.present?
        cdn_variant(resize_to_limit: [600, 600])
      else
        # There is no `image_pack_path` -- see https://github.com/rails/webpacker/issues/2562
        filename = cover_photo_filename(category_override)
        ActionController::Base.helpers.asset_pack_path "media/images/#{filename}-default.png"
      end
    end
  end

  def cover_photo_filename(category_override = nil)
    # FIXME use slug of category instead? and fallback if this is missing
    category_override.blank? ? self.category.downcase.gsub(' ', '-') : category_override.downcase
  end

  def self.get_featured_projects
    projects_count = Settings.homepage_featured_projects_count
    Project.where(highlight: true).includes(:project_types, :skills, :volunteers).limit(projects_count).order('RANDOM()')
  end

end
