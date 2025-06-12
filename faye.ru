require 'faye'
require 'rack/cors'

Faye::WebSocket.load_adapter('thin')

ENV['RACK_ENV'] = 'production'

# Redirect stderr to a log file
# log_path = '/app/log'
# FileUtils.mkdir_p(log_path) unless File.directory?(log_path)
# $stderr.reopen(File.join(log_path, 'faye.log'), 'w')
# $stderr.sync = true

# Simple Faye configuration optimized for development
faye_app = Faye::RackAdapter.new(
  mount: '/faye',
  timeout: 25
)

# CORS configuration
app_with_cors = Rack::Builder.new do
  use Rack::Cors do
    allow do
      origins '*' # Allow all origins
      resource '*', headers: :any, methods: [:get, :post, :options]
    end
  end
  run faye_app
end

run app_with_cors
