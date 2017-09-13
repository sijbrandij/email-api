class EmailsController < BaseApiController
  before_action :validate_keys
  
  def create
    head :ok
  end
  
  private
  
  def validate_keys
    unless @json.keys.sort == ["body", "from", "from_name", "subject", "to", "to_name"]
      head :bad_request
    end
  end
end