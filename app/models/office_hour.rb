class OfficeHour < ApplicationRecord
  belongs_to :user
  belongs_to :participant, foreign_key: 'participant_id', class_name: 'User', optional: true

  def can_edit?(edit_user)
    edit_user && (self.user == edit_user || edit_user.is_admin?)
  end

  def applied?(user)
    return false if user.blank?

    self.applications.each do |application|
      return true if user == application
    end
    false
  end

  def applications
    User.where(id: self.application_user_ids).all
  end

  def applications_with_projects_json
    self.applications.to_json(only: [ :id, :name, :email ],
      include: { projects: { only: [ :id, :title ] } })
  end

  def participant_json
    return {}.to_json if self.participant.blank?
    self.participant.to_json(only: [ :id, :name, :email ])
  end

  def pretty_duration
    "+#{(self.end_at - self.start_at).to_i / 1.minutes}m"
  end

  def to_calendar
    cal = Icalendar::Calendar.new

    cal.event do |e|
      e.dtstart = self.start_at
      e.dtend = self.end_at
      e.summary = "HWC Office Hour #{self.user.name.split(' ')[0]} #{self.participant.name.split(' ')[0]}"
      e.organizer = Icalendar::Values::CalAddress.new('mailto:helpwithcovid@gmail.com', cn: 'helpwithcovid@gmail.com')

      [ self.user, self.participant ].each do |user|
        attendee_params = {
          'CUTYPE': 'INDIVIDUAL',
          'ROLE': 'REQ-PARTICIPANT',
          'PARTSTAT': 'NEEDS-ACTION',
          'RSVP': 'TRUE',
          'X-NUM-GUESTS': '0',
          'CN': user.email,
        }

        attendee_value = Icalendar::Values::Text.new("mailto:#{user.email}", attendee_params)
        e.append_custom_property('ATTENDEE', attendee_value)
      end
    end

    cal.append_custom_property('METHOD', 'REQUEST')

    cal.to_ical
  end
end
