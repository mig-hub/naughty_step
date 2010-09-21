Gem::Specification.new do |s| 
  s.name = 'naughty-step'
  s.version = "0.0.1"
  s.platform = Gem::Platform::RUBY
  s.summary = "A Rack middleware for simple 404 and 500 status handling"
  s.description = "Just create your 404 and 500 html pages, use the middleware, and that's it."
  s.files = `git ls-files`.split("\n").sort
  s.test_files = ['spec.rb']
  s.require_path = '.'
  s.author = "Mickael Riga"
  s.email = "mig@mypeplum.com"
  s.homepage = "http://github.com/mig-hub/naughty_step"
end