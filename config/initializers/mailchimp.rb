
Rails.application.configure do
    config.mailchimp_api_key = ENV['MAILCHIMP_API_KEY']
    config.mailchimp_list_id = ENV['MAILCHIMP_LIST_ID'] 
end

