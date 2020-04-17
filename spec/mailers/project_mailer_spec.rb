require 'rails_helper'

RSpec.describe ProjectMailer, type: :mailer do
  context "#new_volunteer" do
    let(:owner) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project, user: owner) }
    let(:volunteer) { FactoryBot.create(:volunteer, user: create(:user), project: project) }
    let(:mail) { ProjectMailer.with(project: project, user: volunteer.user, note: volunteer.note).new_volunteer }

    it "sends an email to the owner" do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(mail.from).to eq(["no-reply@helpwithcovid.com"])
      expect(mail.to).to eq([project.user.email])
    end

    context "when volunteer can receive volunteer notifications" do
      before { volunteer.abilities << VolunteerAbility.new(permission: VolunteerAbility.permissions[:receive_volunteer_notifications]) }

      it "sends an email to the owner and the volunteer" do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(mail.from).to eq(["no-reply@helpwithcovid.com"])
      expect(mail.to).to eq([project.user.email, volunteer.user.email])
      end
    end
  end
end
