require './boot'

map '/svc/' do
  run Rack::URLMap.new(
    '/projects' => Services::Projects
  )
end
