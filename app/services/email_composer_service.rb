class EmailComposerService
  require 'rest-client'
  
  def initialize(params)
    @to = params['to']
    @to_name = params['to_name']
    @from = params['from']
    @from_name = params['from_name']
    @subject = params['subject']
    @body = params['body']
  end
  
  def send
    response = RestClient.post "https://api:#{ENV['MAILGUN_API_KEY']}"\
    "@api.mailgun.net/v3/#{ENV["MAILGUN_DOMAIN_NAME"]}/messages",
    :from => "#{@from_name} <#{@from}>",
    :to => "#{@to}",
    :subject => "#{@subject}",
    :text => "#{@body}"
    response.code == 200
  end
end

# email = EmailComposerService.new({'to' => 'user@example.com', 'to_name' => 'Some User', 'from' => 'brightwheel@example.com', 'from_name' => 'Brightwheel', 'subject' => 'A message for you!', 'body' => 'Some body'})
# email.send