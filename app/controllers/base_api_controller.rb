class BaseApiController < ApplicationController
  before_action :parse_request
  
  private
  
  def parse_request
    @json = JSON.parse(request.body.read)
    @json['body'] = ActionController::Base.helpers.strip_tags(@json['body'])
  end
end