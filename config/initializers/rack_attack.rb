class Rack::Attack
    # # Allow all requests from localhost
    # safelist('allow-localhost') do |req|
    #   '127.0.0.1' == req.ip || '::1' == req.ip
    # end
  
    # Limit requests to the calculate_all_taxes endpoint to 100 requests per hour per IP
    throttle('calculate_all_taxes', limit: 50, period: 1.hour) do |req|
      if req.path == '/calculate/consolidated_taxes' && req.post?
        puts "IP: #{req.ip}"
        req.ip
      end
    end
  end
  