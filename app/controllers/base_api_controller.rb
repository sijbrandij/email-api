class BaseApiController < ApplicationController
  before_action :parse_request
  
  private
  
  def parse_request
    @json = JSON.parse(request.body.read)
  end
end