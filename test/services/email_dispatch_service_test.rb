require 'test_helper'

class EmailDispatchServiceTest < ActiveSupport::TestCase
  test 'should initialize service and assign variables' do
    params = {
      'to' => 'karen.sijbrandij@gmail.com',
      'to_name' => 'Test User',
      'from' => 'anotheruser@example.com',
      'from_name' => 'Another User',
      'subject' => 'A message for you',
      'body' => 'Your bill $10'
    }
    email = EmailDispatchService.new(params)
    assert_not_nil email.instance_values['to']
    assert_not_nil email.instance_values['to_name']
    assert_not_nil email.instance_values['from']
    assert_not_nil email.instance_values['from_name']
    assert_not_nil email.instance_values['subject']
    assert_not_nil email.instance_values['body']
  end
  
  test 'should send an email using mailgun' do
    params = {
      'to' => 'karen.sijbrandij@gmail.com',
      'to_name' => 'Test User',
      'from' => 'anotheruser@example.com',
      'from_name' => 'Another User',
      'subject' => 'A message for you',
      'body' => 'Your bill $10'
    }
    email = EmailDispatchService.new(params)
    assert_equal true, email.send
  end
  
  test 'should send an email using sendgrid' do
    ENV['SERVICE_PROVIDER'] = 'SENDGRID'
    params = {
      'to' => 'karen.sijbrandij@gmail.com',
      'to_name' => 'Test User',
      'from' => 'anotheruser@example.com',
      'from_name' => 'Another User',
      'subject' => 'A message for you',
      'body' => 'Your bill $10'
    }
    email = EmailDispatchService.new(params)
    assert_equal true, email.send
    ENV['SERVICE_PROVIDER'] = 'MAILGUN'
  end
end