class ApplicationMailer < ActionMailer::Base
  default from: "Help With Covid New Haven <#{HWC_NOREPLY}>"
  layout 'mailer'
end
