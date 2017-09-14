class EmailDispatchService
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
    if provider == 'MAILGUN'
      response = RestClient.post "#{api_key}"\
        "#{domain_name}",
        :from => "#{@from_name} <#{@from}>",
        :to => "#{@to_name} <#{@to}>",
        :subject => "#{@subject}",
        :text => "#{@body}"
      response.code == 200
    elsif provider == 'SENDGRID'
      response = RestClient.post "#{domain_name}", 
        data_for_sendgrid.to_json,
        :content_type => :json,
        :accept => :json,
        :Authorization=> "Bearer #{api_key}"
      response.code == 202
    end
  end
  
  private
  
  def provider
    @provider ||= ENV['SERVICE_PROVIDER']
  end
  
  def api_key
    ENV["#{provider}_API_KEY"]
  end
  
  def domain_name
    ENV["#{provider}_DOMAIN_NAME"]
  end
  
  def data_for_sendgrid
    { 'personalizations':
      [
        {
          'to': [
            {
              'email': @to,
              'name': @to_name
            }
          ]
        }
      ],
      'from': {
        'email': @from,
        'name': @from_name
      },
      'subject': @subject,
      'content': [
        {
          'type': 'text/plain',
          'value': @body
        }
      ]
    }
  end
end