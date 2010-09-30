module Rack
  class NaughtyStep
    F = ::File
    def initialize(app, loc_not_found='public/404.html', loc_error='public/500.html')
      @app = app
      @loc_not_found = loc_not_found
      @loc_error = loc_error
    end
    def call(env)
      status, headers, body = @app.call(env)
      if status==404
        body = F.read(@loc_not_found)
        headers['Content-Type'] = 'text/html'
        headers['Content-Length'] = body.size.to_s
      end
      [status,headers,body]
    rescue StandardError, LoadError, SyntaxError => e
      # Log like on ::Rack::ShowExceptions
      env["rack.errors"].puts "#{e.class}: #{e.message}"
      env["rack.errors"].puts e.backtrace.map { |l| "\t" + l }
      env["rack.errors"].flush
      # Prepare 500 page
      body = F.read(@loc_error)
      headers = {'Content-Type' => 'text/html', 'Content-Length' => body.size.to_s}
      # Render
      [500, headers, body]
    end
  end
end