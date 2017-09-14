require 'test_helper'

class EmailsControllerTest < ActionDispatch::IntegrationTest
  def test_that_email_is_sent_using_mailgun
    payload = {
      to: 'karen.sijbrandij@gmail.com',
      to_name: 'Test User',
      from: 'anotheruser@example.com',
      from_name: 'Another User',
      subject: 'A message for you',
      body: '<h1>Your bill</h1><p> $10</p>'
    }
    post "/email", params: payload.to_json
    assert_response :success
  end
  
  def test_that_email_is_sent_using_sendgrid
    ENV['SERVICE_PROVIDER'] = 'SENDGRID'
    payload = {
      to: 'karen.sijbrandij@gmail.com',
      to_name: 'Test User',
      from: 'anotheruser@example.com',
      from_name: 'Another User',
      subject: 'A message for you',
      body: '<h1>Your bill</h1><p> $10</p>'
    }
    post "/email", params: payload.to_json
    assert_response :success
  end
  
  def test_that_bad_keys_are_not_accepted
    payload = {
      to: 'karen.sijbrandij@gmail.com',
      to_name: 'Test User',
      from: 'anotheruser@example.com',
      from_name: 'Another User',
      subject: 'A message for you',
      body: '<h1>Your bill</h1><p> $10</p>',
      bad_key: "I don't belong here!"
    }
    post "/email", params: payload.to_json
    assert_response :bad_request
  end
  
  def test_that_empty_values_are_not_accepted
    payload = {
      to: 'karen.sijbrandij@gmail.com',
      to_name: ' ',
      from: 'anotheruser@example.com',
      from_name: 'Another User',
      subject: 'A message for you',
      body: '<h1>Your bill</h1><p> $10</p>'
    }
    post "/email", params: payload.to_json
    assert_response :bad_request
  end
  
  def test_that_unsupported_service_provider_does_not_send_email
    ENV['SERVICE_PROVIDER'] = 'TWILIO'
    payload = {
      to: 'karen.sijbrandij@gmail.com',
      to_name: 'Test User',
      from: 'anotheruser@example.com',
      from_name: 'Another User',
      subject: 'A message for you',
      body: '<h1>Your bill</h1><p> $10</p>'
    }
    post "/email", params: payload.to_json
    assert_response :service_unavailable
  end
  
  def teardown
    ENV['SERVICE_PROVIDER'] = 'MAILGUN'
  end
end