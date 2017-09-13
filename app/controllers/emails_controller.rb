class EmailsController < BaseApiController
  before_action :validate_keys
  before_action :validate_input
  
  def create
    head :ok
  end
  
  private
  
  def validate_keys
    unless @json.keys.sort == ["body", "from", "from_name", "subject", "to", "to_name"]
      head :bad_request
    end
  end
  
  def validate_input
    # Check for blank values
    if @json.values.select{|v| v.blank? }.any?
      head :bad_request
    end
  end
end