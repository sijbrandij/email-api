class EmailComposerService  
  def initialize(params)
    @to = params['to']
    @to_name = params['to_name']
    @from = params['from']
    @from_name = params['from_name']
    @subject = params['subject']
    @body = params['body']
  end
  
  def send
    response = %x{ curl -s --user "api:key-#{ENV['MAILGUN_API_KEY']}" "https://api.mailgun.net/v3/#{ENV['MAILGUN_DOMAIN_NAME']}/messages" -F from="#{@from_name} <#{@from}>" -F to="#{@to_name} <#{@to}>" -F subject="#{@subject}" -F text="#{@body}" }
    response = JSON.parse(response)
    response["message"] == "Queued. Thank you."
  end
end

# email = EmailComposerService.new({'to' => 'user@example.com', 'to_name' => 'Some User', 'from' => 'brightwheel@example.com', 'from_name' => 'Brightwheel', 'subject' => 'A message for you!', 'body' => 'Some body'})
# email.send