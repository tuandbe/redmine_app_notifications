# Ensure Rack environment is set to production to disable Rack::Lint
ENV['RACK_ENV'] = 'production'

require 'faye'

# Simple Faye configuration optimized for development
bayeux = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
run bayeux
