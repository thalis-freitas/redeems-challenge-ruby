class ApiController < ApplicationController
  rescue_from ActiveRecord::ActiveRecordError do |_exception|
    head :internal_server_error
  end

  rescue_from ActiveRecord::RecordNotFound do |_msg|
    head :not_found
  end
end
