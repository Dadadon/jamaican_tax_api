class ApplicationController < ActionController::API
    rescue_from Rack::Attack::Throttle, with: :render_rate_limited
  
    private
  
    def render_rate_limited
      render json: { error: 'Rate limit exceeded. Try again later.' }, status: :too_many_requests
    end
end
  