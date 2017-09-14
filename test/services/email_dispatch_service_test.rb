require 'test_helper'

class EmailDispatchServiceTest < ActiveSupport::TestCase
  def test_that_initialize_assigns_variables
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
  
  def test_that_send_sends_email_through_mailgun
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
  
  def test_that_send_sends_email_through_sendgrid
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
  end
  
  def test_that_email_is_not_sent_with_unsupported_service_provider
    ENV['SERVICE_PROVIDER'] = 'TWILIO'
    params = {
      'to' => 'karen.sijbrandij@gmail.com',
      'to_name' => 'Test User',
      'from' => 'anotheruser@example.com',
      'from_name' => 'Another User',
      'subject' => 'A message for you',
      'body' => 'Your bill $10'
    }
    email = EmailDispatchService.new(params)
    assert_nil email.send
  end
  
  def teardown
    ENV['SERVICE_PROVIDER'] = 'MAILGUN'
  end
end