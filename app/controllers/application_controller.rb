class ApplicationController < ActionController::API
  def json_response(json, status = 200)
    render json: json, status: status
  end
end
