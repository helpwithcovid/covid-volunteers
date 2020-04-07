require 'csv'
require 'gibbon'
require 'net/https'
require 'json'

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

  pg_search_scope :search, against: %i(name email about location remote_location level_of_availability affiliation)

  def volunteered_for_project? project
    self.volunteered_projects.where(id: project.id).exists?
  end

  def has_complete_profile?
    self.about.present? && self.name.present?
  end

  def true_location
    return "#{REMOTE_LOCATION} (#{self.remote_location})" if self.location == REMOTE_LOCATION
    return self.location
  end

  def is_visible_to_user?(user_trying_view)
    return true if self.visibility == true
    return true if user_trying_view && user_trying_view.is_admin?
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
    attributes = %w{email about profile_links location remote_location level_of_availability phone affiliation resume}

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

  # this function uses Gibbon and Mailchimp API to subscribe/unsubscribe users
  def subscribe_to_mailchimp(action = true)
    gibbon = Gibbon::Request.new
    gibbon.timeout = 15
    list_id = "97d3425a6c"

    response = gibbon.lists(list_id).members(Digest::MD5.hexdigest(self.email)).upsert(body: {
        email_address: self.email, 
        status: action ? "subscribed" : "unsubscribed", 
    })
  
    response
  end

  # this function checks the newsletter_consent field in before_save
  def check_newsletter_consent
    if self.newsletter_consent
        subscribe_to_mailchimp(true)
    else 
        subscribe_to_mailchimp(false)
    end
  end

  # this function is used with before_create
  def opt_into_newsletter_on_sign_up
    self.newsletter_consent = true
    subscribe_to_mailchimp(true)
  end   

  # this function checks if this user has completed Blank Slate training
  def finished_training?
    uri = URI.parse("https://app.blankslatetechnologies.com/sreo/v0.1/app/covidvolunteers/user/check-status")
    request = Net::HTTP::Post.new(uri)
    request.basic_auth("helpwithcovid@gmail.com", "C6XfTc12")
    request.content_type = "application/json"
    request.body = JSON.dump({
      "email" => self.email
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    if response.code == "200"
      result = JSON.parse(response.body)
      result['finishedAllCards']
    else
      false
    end
  end

  # <%= image_tag('ex-mark.svg', :size => "30x20") %>

  # before saving, we check if the user opted in or out, 
  # if so they will be subscribed or unsubscribed
  # TODO: prevent unnecessary requests to mailchimp by checking the previous state
  before_update :check_newsletter_consent

  # after sign up, the user will be opted into the newsletter by default
  before_create :opt_into_newsletter_on_sign_up

end
