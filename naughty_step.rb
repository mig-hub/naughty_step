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
      body = F.read(@loc_error)
      headers = {'Content-Type' => 'text/html', 'Content-Length' => body.size.to_s}
      [500, headers, body]
    end
  end
end