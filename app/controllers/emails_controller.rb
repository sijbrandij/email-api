class EmailsController < BaseApiController
  before_action :validate_keys, only: [:create]
  before_action :validate_input, only: [:create]
  
  def create
    email = EmailDispatchService.new(@json)
    if email.send
      head :ok
    else
      head :error
    end
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
    
    # TODO: validate email formats
  end
end