# config/initializers/secure_headers.rb

SecureHeaders::Configuration.default do |config|
    config.csp = {
      # Specify your CSP directives here
      # For example:
      default_src: %w('self'),
      script_src: %w('self' 'unsafe-inline'),
      style_src: %w('self' 'unsafe-inline'),
      img_src: %w('self' data:),
      connect_src: %w('self'),
      font_src: %w('self'),
      object_src: %w('none'),
      media_src: %w('self'),
      frame_src: %w('self')
    }
  
    # Other secure headers configurations can be added here
  end
  
  SecureHeaders::Configuration.override(:api) do |config|
    # Override the default configuration for your API
    # For example:
    config.csp = {
      default_src: %w('none')
    }
  end
  