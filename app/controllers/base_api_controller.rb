class BaseApiController < ApplicationController
  before_action :parse_request, except: [:thanks]
  
  
  def thanks
    render json: {"message" => "Queued. Thank you."}.to_json
  end
  
  private
  
  def parse_request
    @json = JSON.parse(request.body.read)
    @json['body'] = ActionController::Base.helpers.strip_tags(@json['body'])
  end
end