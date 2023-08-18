class ApplicationController < ActionController::API
    rescue_from Rack::Attack::Throttle, with: :render_rate_limited
    rescue_from ArgumentError, with: :render_invalid_input
  
    private
  
    def render_rate_limited
      render json: { error: 'Rate limit exceeded. Try again later.' }, status: :too_many_requests
    end

    def render_invalid_input(exception)
      render json: { error: exception.message }, status: :bad_request
    end
end
  