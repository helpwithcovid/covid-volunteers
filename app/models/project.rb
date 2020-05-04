class Project < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  include PgSearch::Model

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

    Rails.cache.delete "project_cdn_cover_photo_#{id}"
  end

  validates :status, inclusion: { in: ALL_PROJECT_STATUS }

  before_validation :default_values

  def default_values
    self.status = ALL_PROJECT_STATUS.first if self.status.blank?
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

  # Because Active Storage doesn't support serving files through cloudfront (or any other way)
  # we need to manually strip the S3 path and prepend it with the CDN url
  def cdn_url(url)
    regex = /.*amazonaws\.com(\/variants\/.*\/.*)\?/
    path = regex.match(url).captures

    return url if path.nil?

    "#{ENV['CDN_URL']}#{path.first}"
  end

  def cover_photo(category_override = nil)
    Rails.cache.fetch("project_cdn_cover_photo_#{id}_#{category_override}", expires_in: 1.month) do
      if self.image.present?
        resized_variant = self.image.variant(resize_to_limit: [600, 600])

        begin
          # Making sure the variant is processed before serving
          cdn_url(resized_variant.processed.service_url)
        rescue
          resized_variant.service_url
        end
      else
        "/images/#{category_override.blank? ? self.category.downcase : category_override.downcase}-default.jpg"
      end
    end
  end

  def self.get_featured_projects
    Project.where(highlight: true).includes(:project_types, :skills, :volunteers).limit(3).order('RANDOM()')
  end
end
