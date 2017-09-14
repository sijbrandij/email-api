require 'test_helper'

class EmailsControllerTest < ActionDispatch::IntegrationTest
  test "should send email" do
    payload = {
      to: 'karen.sijbrandij@gmail.com',
      to_name: 'Test User',
      from: 'brightwheel@example.com',
      from_name: 'Brightwheel',
      subject: 'A message for you',
      body: '<h1>Your bill</h1><p>$10</p>'
    }
    post "/email", params: payload.to_json
    assert_response :success
  end
  
  test "should not accept bad keys" do
    payload = {
      to: 'karen.sijbrandij@gmail.com',
      to_name: 'Test User',
      from: 'brightwheel@example.com',
      from_name: 'Brightwheel',
      subject: 'A message for you',
      body: '<h1>Your bill</h1><p>$10</p>',
      bad_key: "I don't belong here!"
    }
    post "/email", params: payload.to_json
    assert_response :bad_request
  end
  
  test "should not accept empty values" do
    payload = {
      to: 'karen.sijbrandij@gmail.com',
      to_name: ' ',
      from: 'brightwheel@example.com',
      from_name: 'Brightwheel',
      subject: 'A message for you',
      body: '<h1>Your bill</h1><p>$10</p>'
    }
    post "/email", params: payload.to_json
    assert_response :bad_request
  end
end